(ns adventofcode.2024.01
  (:require [clojure.string :as str]))

;; does clojure seriously not have an identity function?
(defn id [& x] x)

;; also works as unzip (magic? maybe this should be called transpose)
(defn zip [x]
  (apply map list x))

(defn parse-line [line]
  (map parse-long (str/split line #"\s+")))

(defn parse-file [file]
  (map parse-line (str/split-lines file)))

(defn pair-numbers [pairs]
  (zip (map sort (zip pairs))))

(defn abs-diff [pair]
  (abs (- (first pair) (second pair))))

(defn f1 []
  (let [in (parse-file (slurp *in*))
        pairs (pair-numbers in)]
    (apply + (map abs-diff pairs))))

(println (f1))
