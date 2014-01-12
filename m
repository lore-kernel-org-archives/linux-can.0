From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils 2/3] ioctl.h: drop unused header
Date: Sun, 12 Jan 2014 11:18:51 +0100
Message-ID: <52D26C0B.7080109@hartkopp.net>
References: <20130817190521.GK30496@pengutronix.de> <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389481823-8379-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:52275 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaALKSx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 05:18:53 -0500
In-Reply-To: <1389481823-8379-3-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

This is a relict from the first implementation of a CAN driver configur=
ation
interface from 2006.

As the current can-utils do not reference them nor the ioctl interface =
has any
relevance removing this file is a good idea :-)

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx Uwe!

On 12.01.2014 00:10, Uwe Kleine-K=F6nig wrote:
> This header doesn't exist in the Linux tree and it's unused by can-ut=
ils,
> so drop it. As a side effect this fixes the last file not specifying =
any
> license and/or copyright information.
> ---
>  GNUmakefile.am                |  1 -
>  include/socketcan/can/ioctl.h | 99 ---------------------------------=
----------
>  2 files changed, 100 deletions(-)
>  delete mode 100644 include/socketcan/can/ioctl.h
>=20
> diff --git a/GNUmakefile.am b/GNUmakefile.am
> index fc8f6e73e139..8c18e72794fa 100644
> --- a/GNUmakefile.am
> +++ b/GNUmakefile.am
> @@ -23,7 +23,6 @@ noinst_HEADERS =3D \
>  	include/socketcan/can/error.h \
>  	include/socketcan/can/gw.h \
>  	include/socketcan/can.h \
> -	include/socketcan/can/ioctl.h \
>  	include/socketcan/can/isotp.h \
>  	include/socketcan/can/netlink.h \
>  	include/socketcan/can/raw.h
> diff --git a/include/socketcan/can/ioctl.h b/include/socketcan/can/io=
ctl.h
> deleted file mode 100644
> index ab34e8918667..000000000000
> --- a/include/socketcan/can/ioctl.h
> +++ /dev/null
> @@ -1,99 +0,0 @@
> -
> -/*
> - * socketcan/can/ioctl.h
> - *
> - * Definitions for CAN controller setup (work in progress)
> - *
> - * $Id$
> - *
> - * Send feedback to <linux-can@vger.kernel.org>
> - *
> - */
> -
> -#ifndef CAN_IOCTL_H
> -#define CAN_IOCTL_H
> -
> -#include <linux/sockios.h>
> -
> -/*
> - * CAN bitrate
> - */
> -#define CAN_BITRATE_UNCONFIGURED	((__u32) 0xFFFFFFFFU)
> -#define CAN_BITRATE_UNKNOWN		0
> -#define CAN_BITRATE_DEFAULT		500000
> -
> -/*
> - * CAN custom bit time
> - */
> -enum can_bittimes {
> -	CAN_BITTIME_STD,
> -	CAN_BITTIME_BTR
> -};
> -
> -/* TSEG1 of controllers usually is a sum of synch_seg (always 1),
> - * prop_seg and phase_seg1, TSEG2 =3D phase_seg2 */
> -
> -struct can_bittime_std {
> -	__u32 brp;        /* baud rate prescaler */
> -	__u8  prop_seg;   /* from 1 to 8 */
> -	__u8  phase_seg1; /* from 1 to 8 */
> -	__u8  phase_seg2; /* from 1 to 8 */
> -	__u8  sjw:7;      /* from 1 to 4 */
> -	__u8  sam:1;      /* 1 - enable triple sampling */
> -};
> -
> -struct can_bittime_btr {
> -	__u8  btr0;
> -	__u8  btr1;
> -};
> -
> -struct can_bittime {
> -	enum can_bittimes type;
> -	union {
> -		struct can_bittime_std std;
> -		struct can_bittime_btr btr;
> -	};
> -};
> -
> -/*
> - * CAN mode
> - */
> -enum can_mode {
> -	CAN_MODE_STOP =3D 0,
> -	CAN_MODE_START,
> -	CAN_MODE_SLEEP
> -};
> -
> -/*
> - * CAN controller mode
> - */
> -#define CAN_CTRLMODE_LOOPBACK   0x1
> -#define CAN_CTRLMODE_LISTENONLY 0x2
> -
> -/*
> - * CAN operational and error states
> - */
> -enum can_state {
> -	CAN_STATE_ACTIVE =3D 0,
> -	CAN_STATE_BUS_WARNING,
> -	CAN_STATE_BUS_PASSIVE,
> -	CAN_STATE_BUS_OFF,
> -	CAN_STATE_STOPPED,
> -	CAN_STATE_SLEEPING
> -};
> -
> -/*
> - * CAN device statistics
> - */
> -struct can_device_stats {
> -	int error_warning;
> -	int data_overrun;
> -	int wakeup;
> -	int bus_error;
> -	int error_passive;
> -	int arbitration_lost;
> -	int restarts;
> -	int bus_error_at_init;
> -};
> -
> -#endif /* CAN_IOCTL_H */
>=20
