{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE GADTs #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Type.Family.Pair
-- Copyright   :  Copyright (C) 2015 Kyle Carter
-- License     :  BSD3
--
-- Maintainer  :  Kyle Carter <kylcarte@indiana.edu>
-- Stability   :  experimental
-- Portability :  RankNTypes
--
-- Type-level pairs, along with some convenient aliases and type families
-- over them.
--
-----------------------------------------------------------------------------

module Type.Family.Pair where

import Type.Family.Monoid

type (#) = '(,)
infixr 6 #

type family Fst (p :: (k,l)) :: k where
  Fst '(a,b) = a

type family Snd (p :: (k,l)) :: l where
  Snd '(a,b) = b

type family (f :: k -> l) <$> (a :: (m,k)) :: (m,l) where
  f <$> (a#b) = a # f b
infixr 4 <$>

type family (f :: (m,k -> l)) <&> (a :: k) :: (m,l) where
  (r#f) <&> a = r # f a
infixr 4 <&>

type family (f :: (m,k -> l)) <*> (a :: (m,k)) :: (m,l) where
  (r#f) <*> (s#a) = (r <> s) # f a
infixr 4 <*>

-- | A type-level pair is a Monoid over its pairwise components.
type instance Mempty = Mempty # Mempty
type instance (r#a) <> (s#b) = (r <> s) # (a <> b)

