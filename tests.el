(load-file "./solution.el")

(assert (eq 4 4))


(assert (eq (add 4 5) 9))

(assert )

(assert (equal (sum-number-with-sequence 5 (list 1 1)) (list 6 6)))

(setq sequence (list 1 2 3 4 5))

(setq null-index (length sequence))

(assert (eq (generate-sequence-at-index sequence null-index) nil))

(setq last-index (- (length sequence) 1))

(setq add-five-to-sequence (sum-number-with-sequence 5 sequence))

; add 5 to the sequence and remove the value at the index with value 5
(setq add-five-except-last (remove (nth (- (length add-five-to-sequence) 1) add-five-to-sequence) add-five-to-sequence))

; generate the final sequence
(assert (equal (generate-sequence-at-index sequence last-index) add-five-except-last))

(setq easy-sequence (list 1 1 2))

; show that we can correctly generate a simple sequence of possible combinations
; note the resulting issue of duplicates, will slow things down
(assert (equal (generate-sequence-combinations easy-sequence) (list 3 3)))

(generate-sequence-combinations easy-sequence)

(assert (equal (generate-lookback-sequence sequence 2 1) (list 1)))

(assert (equal (generate-lookback-sequence sequence 3 2) (list 1 2)))

(defun test-correct-lookback-generation ()
  "Should generate correct lookback sequence"
  (let (
      (index 1)
      (lookback-size 1)
      )
  (generate-lookback-sequence sequence index lookback-size)
  )
)

(defun test-correct-lookback-generation-2 ()
  "Should generate correct lookback sequence"
  (let (
        (index 2)
        (lookback-size 2)
        )
    (generate-lookback-sequence sequence index lookback-size)
    )
  )

(assert (equal (test-correct-lookback-generation) (list 1)))

(assert (equal (test-correct-lookback-generation-2) (list 1 2)))

; check on how -contains? works
(assert (eq (-contains? (list 5 4) 5) t))

(defun test-isvalid-helper-setup ()
    "Check whether isvalid is working properly"
  (let (
        (number 3)
        (combinations (list 3)) ; contains 3
        )
    (isvalid-helper number combinations)
    )
  )

(assert (test-isvalid-helper-setup))

(assert (isvalid 2 (list 1 2 3) 2))
(assert (eq (isvalid 2 (list 1 2 2) 2) nil))


(isvalid 2 (list 1 2 3) 2)

; assert that checking at an invalid index returns nil
(assert (eq (find-invalid-sequence 3 (list 1 2 3) 2) nil))

; assert that if all values at/after index are valid then return nil
(assert (eq (find-invalid-sequence 3 (list 1 2 3) 2) nil))

; assert that the first index is not valid
(assert (eq (find-invalid-sequence 0 (list 1 2 3) 2) 0))


