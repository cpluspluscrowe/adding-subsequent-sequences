(setq input (f-read-text "input.txt" 'utf-8))
(setq input-sequence (-map #'string-to-number (butlast (split-string input "\n"))))
(setq length-of-sequence-to-consider 5)

(defun add (x y)
  (+ x y))

(defun sum-number-with-sequence (to-add relevant-sequence)
  "Return a list of the sequence with each number incremented by to-add"
(-map (-partial #'add to-add) relevant-sequence))

(defun generate-sequence-at-index (sequence index)
  "Create the list of sequence of length length-of-sequence-to-consider before index, which are incremented by the value at index"
; base case
  (if (eq (length sequence) index) nil
    (let (
          (number (nth index sequence))
          )
      ; else return a sequence of the numbers incremented by the value at index
      (append
       (num-number-with-sequence number (-remove-item number sequence))
       (generate-sequence-at-index sequence (+ index 1))
       )
    )
  ))

 (defun generate-sequence-combinations (relevant-sequence)
   (generate-sequence-at-index sequence 0)
   )

(defun isvalid(index sequence)
  "Returns if two different values in the sequence length-of-sequence-to-consider values before in the list add to equal the value at sequence"
   (let* (
         (number (nth index sequence))
         (relevant-sequence (-slice sequence (- index length-of-sequence-to-consider) index))
         (combinations (generate-sequence-combinations relevant-sequence))
         )
     (-contains? number combinations)
  ))

(defun find-invalid-sequence (index)
  "increment through all indexes until it finds an invalid number or processes all numbers"
  ; return if we run through all values
  (if (eq index (length input-sequence)) nil
    ; base case, if valid then try the next value
    (if (isvalid index input-sequence) (find-invalid-sequence (+ 1 index))
      index)
  ))

(find-invalid-sequence 0)

