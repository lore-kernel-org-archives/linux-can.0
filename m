From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH] Add TX limit for SocketCAN.
Date: Thu, 31 Aug 2017 20:01:31 -0700
Message-ID: <CANGgnMb5-cKT=PjxEF6yYAcUkcP29BRnHU+_xY3ASsT-GQ6qzQ@mail.gmail.com>
References: <1504232079-2583-1-git-send-email-zhongjie.shi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36451 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdIADBx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Aug 2017 23:01:53 -0400
Received: by mail-yw0-f172.google.com with SMTP id h127so6781318ywf.3
        for <linux-can@vger.kernel.org>; Thu, 31 Aug 2017 20:01:52 -0700 (PDT)
In-Reply-To: <1504232079-2583-1-git-send-email-zhongjie.shi@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: zhongjie.shi@intel.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On Thu, Aug 31, 2017 at 7:14 PM,  <zhongjie.shi@intel.com> wrote:
> From: "Shi, Zhongjie" <zhongjie.shi@intel.com>
>
> This will be used to prevent malicious or unintentional
> flooding of messages via SocketCAN.
>
> Change-Id: I6c2e122e12a594d9ad7dc4bdeebe15a1929eb893
> Tracked-On: https://jira01.devtools.intel.com/browse/OAM-48496
> Signed-off-by: Shi, Zhongjie <zhongjie.shi@intel.com>
> ---
>  net/can/Kconfig  | 13 +++++++++++++
>  net/can/af_can.c | 15 +++++++++++++++
>  net/can/af_can.h |  5 +++++
>  net/can/proc.c   | 13 +++++++++++++
>  4 files changed, 46 insertions(+)
>
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index a15c0e0..aeba3d0 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -51,6 +51,19 @@ config CAN_GW
>           They can be modified with AND/OR/XOR/SET operations as configured
>           by the netlink configuration interface known e.g. from iptables.
>
> +config CAN_TX_ATTEMPT_RATE_LIMIT
> +       int "Tx attempt rate limit"
> +       default "5"
> +       ---help---
> +         This TX attempt rate limit can be used to prevent flood of messages
> +         from user space. It's TX "attempt" rate here instead of the "actual"
> +         TX rate because we do the statistics for the TX attempt no matter if
> +         the message TX is actually sent successful or not. The current
> +         default value is "5" which means 5 messages per second that is proper
> +         for an in-vehicle infotainment (IVI) system. For the use cases other
> +         than IVI, this can be set to the value corresponding to the specific
> +         requirement.
> +
>  source "drivers/net/can/Kconfig"
>
>  endif

This default breaks our systems.  We send hundreds of messages/sec,
and at worst case when pushing an update out over CAN to other ECUs,
saturate the bus.  This should be opt in.

I have vague recollections from Oliver long ago that you can use
queueing disciplines to rate limit the interface, which should
implement this without any kernel changes.

Austin
