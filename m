From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <hj.oertel@t-online.de>
Subject: Re: Fwd: can-utils at http://gitorious.org/+linux-can-developers/linux-can/can-utils
Date: Sun, 17 Feb 2013 14:00:39 +0100
Message-ID: <8460593.0ZXZdCLvdq@linux-edhj>
References: <7073D121A5DFE9448648C0E083BEA9C96C7AA63220@vsrv6.tele-radio.ad> <511E1170.6040409@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61260 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab3BQNAu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 17 Feb 2013 08:00:50 -0500
In-Reply-To: <511E1170.6040409@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, H.Engblom@tele-radio.com

Am Freitag 15 Februar 2013, 11:44:00 schrieb Marc Kleine-Budde:
> let's wait for Oliver to say something to the length. As far as I know
> the canutils already support can-fd, which can send up to 64 bytes. I
> don't know the standard for sure, but maybe they got rid of the RTR in
> canfd.

CAN FD is not supporting RTR frames anymore.
Besides this in classic CAN you can specify a dlc between 0 and 15
in data frames. Nevertheless, for dlc > 8 always max 8 data bytes are in the frame.

 Regards
    Heinz 
