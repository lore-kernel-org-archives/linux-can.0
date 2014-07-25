From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: CAN documentation
Date: Fri, 25 Jul 2014 17:47:37 +0400
Message-ID: <1406296057.9487.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:54099 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbaGYNrn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 09:47:43 -0400
Received: by mail-la0-f52.google.com with SMTP id e16so3120994lan.11
        for <linux-can@vger.kernel.org>; Fri, 25 Jul 2014 06:47:42 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello, guys,

I'm looking at linux-can/can-modules tree:

2011-06-26 12:47 Oliver Hartkopp
  minor doc changes ... tbc

2011-06-10 19:08 Oliver Hartkopp
  documentation: rework chapter numbering & references

...

2010-11-22 19:41 Oliver Hartkopp
  Added new documentation layout contributed by Daniele Venzano.

Why are all these changes still not in the kernel? I'm not sure if this
is a good idea to split the documentation, but the patches introduce
some new helpful information.

Hence a little follow-up question:

> The timestamp on Linux has a resolution of one microsecond and it is
> set automatically at the reception of a CAN frame.

It seems to me this is not entirely true as the kernel has a support for
SO_TIMESTAMPNS socket option for quite a long time. Could you really use
that option with CAN? Does it make sense to use nanosecond timestamps?
I'm also a bit confused whether these are only the software timestamps
or you can somehow get them from a controller too.

