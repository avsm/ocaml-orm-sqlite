(*
 * Copyright (c) 2010 Thomas Gazagnaire <thomas@gazagnaire.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

(** Weak hash tables *)

module type S = sig
	type key
	type 'a t
	val create : int -> 'a t
	val clear : 'a t -> unit
	val add : 'a t -> key -> 'a -> unit
	val replace : 'a t -> key -> 'a -> unit
	val remove : 'a t -> key -> unit
	val merge : 'a t -> key -> 'a -> 'a
	val find : 'a t -> key -> 'a
	val find_all : 'a t -> key -> 'a list
	val mem : 'a t -> key -> bool
	val iter : 'a t -> (key -> 'a -> unit) -> unit
	val fold : 'a t -> (key -> 'a -> 'b -> 'b) -> 'b -> 'b
	val count : 'a t -> int
	val stats : 'a t -> int * int * int * int * int * int
	val to_list : 'a t -> (key * 'a) list
end

module Weak_keys : functor (H : Hashtbl.HashedType) -> S with type key = H.t
module Weak_values : functor (H : Hashtbl.HashedType) -> S with type key = H.t

module type Sig = sig
	type t
	type elt
	val clear : t -> unit
	val length : t -> int
	val create : int -> t
	val to_weakid : t -> elt -> int64
	val of_weakid : t -> int64 -> elt list
	val mem : t -> elt -> bool
	val mem_weakid : t -> int64 -> bool
	val add : t -> elt -> int64 -> unit
	val fresh : t -> elt -> int64
	val remove : t -> elt -> unit
	val replace : t -> elt -> int64 -> unit
	val dump : t -> string
end


module Make : functor (H : Hashtbl.HashedType) -> Sig with type elt = H.t
