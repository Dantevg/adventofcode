(ns adventofcode.2024.02
  (:require [clojure.string :as str]))

(defn parse-line [line]
  (map parse-long (str/split line #"\s+")))

(defn parse-file [file]
  (map parse-line (str/split-lines file)))

(defn safe-incr? [report]
  (every? #(<= 1 (apply - %) 3)
          (partition 2 1 report)))

(defn safe? [report]
  (or (safe-incr? report) (safe-incr? (reverse report))))

(defn removings [report]
  (for [i (range 0 (count report))]
    (let [[l r] (split-at i report)]
      (concat l (rest r)))))

(defn safe-with-error? [report]
  (if (safe? report) true
      (some safe? (removings report))))

(def in (parse-file (slurp *in*)))

(defn f1 []
  (count (filter safe? in)))

(defn f2 []
  (count (filter safe-with-error? in)))

;; (println (f1))
(println (f2))
