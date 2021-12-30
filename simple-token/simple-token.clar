;; simple-token
;; Very simple contract with no restrictions.

;; Data variables specific to the deployed token contract
(define-data-var token-name (string-ascii 32) "simple-token")
(define-data-var token-symbol (string-ascii 32) "SMPL")
(define-data-var token-decimals uint u2)
(define-data-var uri (string-utf8 256) u"http://some.json")

;; Meta Read Only Functions for reading details about the contract - conforms to SIP 10
;; --------------------------------------------------------------------------

;; Defines built in support functions for tokens used in this contract
;; A second optional parameter can be added here to set an upper limit on max total-supply
(define-fungible-token simple-token)


;; Get the token balance of the specified owner in base units
(define-read-only (get-balance (owner principal))
  (ok (ft-get-balance simple-token owner)))

;; Returns the token name
(define-read-only (get-name)
  (ok (var-get token-name)))

;; Returns the symbol or "ticker" for this token
(define-read-only (get-symbol)
  (ok (var-get token-symbol)))

;; Returns the number of decimals used
(define-read-only (get-decimals)
  (ok (var-get token-decimals)))

;; Returns the total number of tokens that currently exist
(define-read-only (get-total-supply)
  (ok (ft-get-supply simple-token)))

;; Public getter for the URI
(define-read-only (get-token-uri)
  (ok (some (var-get uri))))

;; Write function to transfer tokens between accounts - conforms to SIP 10
;; --------------------------------------------------------------------------

;; Transfers tokens to a recipient
;; The originator of the transaction (tx-sender) must be the 'sender' principal
;; Smart contracts can move tokens from their own address by calling transfer with the 'as-contract' modifier to override the tx-sender.

(define-public (transfer (amount uint) (sender principal) (recipient principal ))
  (begin
      (asserts! (is-eq tx-sender sender) (err u4)) ;; Ensure the originator is the sender principal
      (ft-transfer? simple-token amount sender recipient) ) ) ;; Transfer

;; Minting and Burning
;; --------------------------------------------------------------------------

;; Mint tokens to address and initialize the contract
(ft-mint? simple-token u100000000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)


;; Burn tokens from the target address
    (define-public (burn-tokens (burn-amount uint) (burn-from principal) )
      (begin
        (asserts! (is-eq tx-sender burn-from) (err u4)) ;; Ensure the originator is the sender principal
        ;; Print the action for any off chain watchers
        (print { action: "burn-tokens", burn-amount: burn-amount, burn-from : burn-from  })
        (ft-burn? simple-token burn-amount burn-from)))
