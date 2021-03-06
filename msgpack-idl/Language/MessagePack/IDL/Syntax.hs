module Language.MessagePack.IDL.Syntax where

import qualified Data.Text as T

type Spec = [Decl]

data Decl
  = MPMessage
    { msgName :: T.Text
    , msgParam :: [T.Text]
    , msgFields :: [Field]
    }
  | MPException
    { excName :: T.Text
    , excParam :: [T.Text]
    , excSuper :: Maybe T.Text
    , excFields :: [Field]
    }
  | MPType
    { tyName :: T.Text
    , tyType :: Type
    }
  | MPEnum
    { enumName :: T.Text
    , enumMem :: [(Int, T.Text)]
    }
  | MPService
    { serviceName :: T.Text
    , serviceVersion :: Maybe Int
    , serviceMethods :: [Method]
    }
  deriving (Eq, Show)

data Field
  = Field
    { fldId :: Int
    , fldType :: Type
    , fldName :: T.Text
    , fldDefault :: Maybe Literal
    }
  deriving (Eq, Show)

data Method
  = Function
    { methodInherit :: Bool
    , methodName :: T.Text
    , methodRetType :: Type
    , methodArgs :: [Field]
    }
  | InheritName T.Text
  | InheritAll
  deriving (Eq, Show)

data Type
  = TInt Bool Int -- signed? bits
  | TFloat Bool   -- double prec?
  | TBool
  | TRaw
  | TString
  | TNullable Type
  | TList Type
  | TMap Type Type
  | TTuple [Type]
  | TUserDef T.Text [Type]
  | TObject
  | TVoid
  deriving (Eq, Show)

data Literal
  = LInt Int
  | LFloat Double
  | LBool Bool
  | LNull
  | LString T.Text
  deriving (Eq, Show)
