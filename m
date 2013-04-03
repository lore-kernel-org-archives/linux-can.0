From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: BCM periodic send
Date: Wed, 03 Apr 2013 20:29:24 +0200
Message-ID: <515C7504.3060403@hartkopp.net>
References: <001e01ce2bce$ec5abcf0$c51036d0$@annecy-elec.fr> <5154B38F.5080404@hartkopp.net> <000501ce3050$1a5fb580$4f1f2080$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:37088 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759285Ab3DCS32 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Apr 2013 14:29:28 -0400
In-Reply-To: <000501ce3050$1a5fb580$4f1f2080$@annecy-elec.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Boris Baskevitch <boris.baskevitch@annecy-elec.fr>
Cc: linux-can@vger.kernel.org

On 03.04.2013 11:46, Boris Baskevitch wrote:

> Now I have a new issue, the BCM report a RX_TIMEOUT for all periodic
> messages, even if the message is present on the bus with a shorter period
> than the one I configured in the BCM.


I assume you set STARTIMER too, which fires the RX timeout timer immediately.

> The message is correctly received as I can get the RX_CHANGED message for
> the corresponding IDs.
> If I use RX_FILTER_ID option, I get a RX_CHANGED and RX_TIMEOUT for each
> message seen the bus (which is correct for RX_CHANGED, but not for
> RX_TIMEOUT).
> By the way, for a periodic RX message, which parameter is the period, ival1
> or ival2 ? (I had both set for the tests)


ival1

Please look into

http://svn.berlios.de/wsvn/socketcan/trunk/test/tst-bcm-dump.c

You can download it from the old BerliOS SVN here:

http://developer.berlios.de/svn/?group_id=6475

An here is, what it does:

hartko@keffi-oh:~$ tst-bcm-dump -?
tst-bcm-dump: invalid option -- '?'

Usage: tst-bcm-dump [options]
Options: -i <interface> (CAN interface. Default: 'vcan0')
         -c <can_id>    (used CAN ID. Default: 0x042)
         -o <timeout>   (Timeout value in nsecs. Default: 0)
         -t <throttle>  (Throttle value in nsecs. Default: 0)
         -q <msgs>      (Quit after receiption of #msgs)
         -s             (set STARTTIMER flag. Default: off)

hartko@keffi-oh:~$ tst-bcm-dump -o 500000
[1365012787.346834] Writing RX_SETUP with RX_FILTER_ID for can_id <042>
[1365012800.057653] (1365012800.057338) RX_CHANGED
[1365012800.557701] RX_TIMEOUT
^C
hartko@keffi-oh:~$ tst-bcm-dump -o 500000 -s
[1365012821.448782] Writing RX_SETUP with RX_FILTER_ID for can_id <042>
[1365012821.948974] RX_TIMEOUT
^C

In the first case the RX_TIMEOUT is 500000ns behind the reception of the
frame. In the second case (with STARTTIMER set) the RX_TIMEOUT emerges even
when there was no reception of any frame.

You can use

cangen vcan0 -I 042 -g400

to test the functionality of above "tst-bcm-dump -o 500000"

When cangen is termintated, the RX_TIMEOUT appears.

Regards,
Oliver

