(ns adventofcode.2024.04
  (:require [clojure.string :as str]))

(defn find-xmas [in]
  (apply + (map #(count (re-seq #"(?=XMAS|SAMX)" %)) in)))

(defn transpose [x] (apply map str x))

(defn diag [n [line & lines]]
  (when (>= n 0)
    (str (nth line n "")
         (diag (dec n) lines))))

(defn rotate-45 [lines]
  (for [i (range (->> lines count (* 2) dec))]
    (diag i lines)))

(def in (str/split-lines (slurp *in*)))

(defn f1 []
  (+ (find-xmas in)
     (find-xmas (transpose in))
     (find-xmas (rotate-45 in))
     (find-xmas (rotate-45 (transpose (reverse in))))))

(defn f2 []
  ())

(println (f1))
