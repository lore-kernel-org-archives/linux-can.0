From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 6/7 v8] can/peak_usb: add peak_usb_netif_rx() new function
Date: Thu, 22 Jan 2015 16:38:32 +0100
Message-ID: <54C11978.200@peak-system.com>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
 <1421940266-6088-7-git-send-email-s.grosjean@peak-system.com>
 <54C117BC.2080905@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57417 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbAVPil (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:38:41 -0500
In-Reply-To: <54C117BC.2080905@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Le 22/01/2015 16:31, Marc Kleine-Budde a =C3=A9crit :
> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>> Add a common function that pushes the skb in the network queue with =
adding
>> timestamps information, converted from time values read from the
>> PEAK USB adapters.
> Why is this function in core.c, it's only used by pcan_usb_fd.c.
>
> Marc
>

Because it should be able to use it from older source files (pcan_usb=20
and pcan_usb_pro, AFAIR)

St=C3=A9phane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
