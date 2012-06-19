From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Tue, 19 Jun 2012 09:39:38 +0200
Message-ID: <4FE02CBA.4040400@hartkopp.net>
References: <4FDF67C3.6020201@hartkopp.net> <4FE02008.6030405@grandegger.com> <4FE02624.2010606@hartkopp.net> <4FE02A13.4030501@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:65278 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab2FSHjh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 03:39:37 -0400
In-Reply-To: <4FE02A13.4030501@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


>> I would wait until this evening if there are more of these remarks and send a
>> v2 then. A review of the documentation would be nice - if everything seems
>> clear to you.
> 
> Where can I pull/fetch the patches from? IIUC, the latest patch series
> you sent is broken.


No. It was only the mail representation which was broken.

The following changes since commit 4670fd819e7f47392c7c6fc6168ea2857c66d163:

  tcp: Get rid of inetpeer special cases. (2012-06-09 01:25:47 -0700)

are available in the git repository at:

  git://gitorious.org/~hartkopp/linux-can/ollis-can-next.git canfd

for you to fetch changes up to d55c45913f93ccbd4378195e2d6ca96b2d14573b:

  canfd: update documentation according to CAN FD extensions (2012-06-17 21:23:55 +0200)

----------------------------------------------------------------

Oliver Hartkopp (6):
  canfd: add new data structures and constants
  canfd: add support for CAN FD in PF_CAN core
  canfd: add support for CAN FD in CAN_RAW sockets
  candev: add/update helpers for CAN FD
  vcan: add CAN FD support
  canfd: update documentation according to CAN FD extensions


(..)
