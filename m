From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: updated candump available in can-utils - Re: pull-request: can-next
 2015-04-01
Date: Wed, 01 Apr 2015 13:27:02 +0200
Message-ID: <551BD606.3040502@hartkopp.net>
References: <551BC2C0.5000408@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:21528 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbDAL1K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Apr 2015 07:27:10 -0400
In-Reply-To: <551BC2C0.5000408@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

If you want to test the new feature:

The latest candump supports the 'join' option with a [j|J] added to the
socket specific filter list:

https://github.com/linux-can/can-utils/commit/1a2467ed29302149d4d1253888ac1f1dfcc11d3f


Feedback & testing is welcome.

Regards,
Oliver

On 01.04.2015 12:04, Marc Kleine-Budde wrote:
> Hello David,
> 
> this is a pull request of 5 patches for net-next/master.
> 
> There are two patches for the ems_usb driver by Gerhard Uttenthaler and
> me, which fix sparse endianess warnings. Oliver Hartkopp adds two
> patches to improve and extend the CAN-ID filter handling on RAW CAN
> sockets. The last patch is by me, it silences an uninitialized variable
> warning in the peak_usb driver.
> 
> Marc
> 
> ---
> 
> The following changes since commit 9911674fcf1f239ff3c87e56177c4826e33dfd95:
> 
>    Merge branch 'ptp-ns_to_timespec64' (2015-03-31 17:19:19 -0400)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-4.1-20150401
> 
> for you to fetch changes up to 79d5eeddd7d23bd4588e370072977928b7075911:
> 
>    can: pcan_usb: pcan_usb_fd_send_cmd(): silence compiler warning about uninitialized var (2015-04-01 11:49:59 +0200)
> 
> ----------------------------------------------------------------
> linux-can-next-for-4.1-20150401
> 
> ----------------------------------------------------------------
> Gerhard Uttenthaler (1):
>        can: ems_usb: fix endianess of CAN ID
> 
> Marc Kleine-Budde (2):
>        can: ems_usb: mark timestamp as little endian
>        can: pcan_usb: pcan_usb_fd_send_cmd(): silence compiler warning about uninitialized var
> 
> Oliver Hartkopp (2):
>        can: fix multiple delivery of a single CAN frame for overlapping CAN filters
>        can: introduce new raw socket option to join the given CAN filters
> 
>   Documentation/networking/can.txt           | 20 ++++++++++--
>   drivers/net/can/usb/ems_usb.c              | 11 +++----
>   drivers/net/can/usb/peak_usb/pcan_usb_fd.c |  2 +-
>   include/uapi/linux/can/raw.h               |  1 +
>   net/can/raw.c                              | 50 ++++++++++++++++++++++++++++++
>   5 files changed, 74 insertions(+), 10 deletions(-)
> 
