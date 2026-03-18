dnl
dnl Check for the fmt library
dnl


AC_MSG_NOTICE([Using the internal version of fmt])
FMT_INTERNAL=yes
ac_cv_fmt_v8=yes

if test $ac_cv_fmt_v8 = yes; then
  AC_DEFINE([HAVE_FMT_V8],[1],[Define if the fmt library is v8 or newer])
fi
AC_SUBST(FMT_INTERNAL)
