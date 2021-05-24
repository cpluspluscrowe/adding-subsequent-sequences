(setq input (f-read-text "input.txt" 'utf-8))
(setq input-sequence (-map #'string-to-number (butlast (split-string input "\n"))))
(setq length-of-sequence-to-consider 5)

(defun add (x y)
  (+ x y))

(defun sum-number-with-sequence (to-add relevant-sequence)
  "Return a list where each number in the sequence is incremented by to-add"
(-map (-partial #'add to-add) relevant-sequence))

(defun generate-sequence-at-index (sequence index)
  "Generate a list where each value in sequence is incrmeented by the value at index.\
   Repeat for all indexes and return the appended list"
; base case
  (if (eq (length sequence) index) nil
    (let (
          (number (nth index sequence))
          )
      ; else return a sequence of the numbers incremented by the value at index
      (append
       (sum-number-with-sequence number (-remove-item number sequence))
       (generate-sequence-at-index sequence (+ index 1))
       )
    )
  ))

 (defun generate-sequence-combinations (relevant-sequence)
   "Added to make the call to generate-sequence-at-index have one fewer argument"
   (generate-sequence-at-index relevant-sequence 0)
   )

(defun generate-lookback-sequence (sequence index lookback-size)
  "Splice sequence to only include values before the index of lookback-size"
  (-slice sequence (- index lookback-size) index)
  )

(defun isvalid-helper (number combinations)
  "Easy way to check isvalid, allows user to supply arguments"
  (-contains? combinations number)
  )

(defun isvalid(index sequence lookback-size)
  "Returns if the value at index is valid for its sequence, where valid is true if two different \
   values in a subsequence, when added, equal the value at index.  \
   The subsequence is comprised of the previous length-of-sequence-to-consider values in the sequence"
   (let* (
         (number (nth index sequence))
         (relevant-sequence (generate-lookback-sequence sequence index lookback-size))
         (combinations (generate-sequence-combinations relevant-sequence))
         )
     (isvalid-helper number combinations)
  ))

(defun find-invalid-sequence (index sequence lookback-size)
  "increment through all indexes until it finds an invalid number or processes all numbers"
  ; return if we run through all values
  (if (>= index (length sequence)) nil
    ; base case, if valid then try the next value
    (if (isvalid index sequence lookback-size) (find-invalid-sequence (+ 1 index) sequence lookback-size)
      (nth index sequence))
  ))

(setq preamble-length 5)
(assert (eq (find-invalid-sequence preamble-length input-sequence length-of-sequence-to-consider) 127))

(setq preamble-length 25)
(find-invalid-sequence preamble-length input-sequence length-of-sequence-to-consider)
