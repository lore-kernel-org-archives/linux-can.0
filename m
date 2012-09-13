From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] can: c_can: Move pm_runtime_enable/disable calls to common code
Date: Thu, 13 Sep 2012 07:14:10 -0700
Message-ID: <87bohaf1sd.fsf@deeprootsystems.com>
References: <1347521292-28751-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1347521292-28751-1-git-send-email-anilkumar@ti.com> (AnilKumar
	Ch's message of "Thu, 13 Sep 2012 12:58:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com
List-Id: linux-can.vger.kernel.org

AnilKumar Ch <anilkumar@ti.com> writes:

> Move pm_runtime_enable/disable calls to c_can.c driver. Current
> implementation is such that platform driver is doing pm_runtime
> enable/disable and core driver is doing put_sync/get_sync.
>
> PM runtime calls should be invoked if there is a valid device
> pointer from platform driver so moving enable/disable calls
> to core driver.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> Incorporated Kevin's comments on "can: c_can: Add runtime PM
> support to Bosch C_CAN/D_CAN controller" patch.

This looks better, but in addition, you can get rid of the
runtime PM helper functions you added (the ones that check for
priv->device) and call the pm_runtime_get/put APIs directly.

Kevin
