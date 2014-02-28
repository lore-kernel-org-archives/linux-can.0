From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v8 0/7] Add CAN FD infrastructure for CAN driver
Date: Fri, 28 Feb 2014 16:18:53 +0100
Message-ID: <5310A8DD.90003@peak-system.com>
References: <1393593549-23072-1-git-send-email-socketcan@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:41581 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbaB1PTO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 10:19:14 -0500
In-Reply-To: <1393593549-23072-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Oliver,

So you have my Acked-by to this v8 serie:

Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>

Le 28/02/2014 14:19, Oliver Hartkopp a =E9crit :
> This is the patch series to extend the CAN driver infrastructure with=
 CAN FD.
>
> Changes v7 -> v8:
>
> Rework if statement in patch 4 according to a suggestion from Marc.
>
> *** BLURB HERE ***
>
> Oliver Hartkopp (7):
>    can: preserve skbuff protocol in can_put_echo_skb
>    can: only send bitrate data via netlink when available
>    can: move sanity check for bitrate and tq into can_get_bittiming
>    can: provide a separate bittiming_const parameter to bittiming
>      functions
>    can: introduce the data bitrate configuration for CAN FD
>    can: allow to change the device mtu for CAN FD capable devices
>    can: add bittiming check at interface open for CAN FD
>
>   drivers/net/can/dev.c            | 154 ++++++++++++++++++++++++++++=
++---------
>   include/linux/can/dev.h          |   7 +-
>   include/uapi/linux/can/netlink.h |   3 +
>   3 files changed, 127 insertions(+), 37 deletions(-)
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
