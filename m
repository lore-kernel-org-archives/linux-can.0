From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/3] can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
Date: Thu, 02 Aug 2012 11:33:59 +0000
Message-ID: <3432187.NhmxBJqHyV@wuerfel>
References: <1343905339-4642-1-git-send-email-anilkumar@ti.com> <1343905339-4642-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63523 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2HBLeL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Aug 2012 07:34:11 -0400
In-Reply-To: <1343905339-4642-2-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: devicetree-discuss@lists.ozlabs.org
Cc: AnilKumar Ch <anilkumar@ti.com>, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, nsekhar@ti.com, anantgole@ti.com

On Thursday 02 August 2012 16:32:17 AnilKumar Ch wrote:
> +- interrupt-parent     : The parent interrupt controller
> +
> +Optional properties:
> +- ti,hwmods            : Must be "d_can<n>" or "c_can<n>", n being the
> +                         instance number

interrupt-parent should be optional, not mandatory. It's usually implied
by the parent's interrupt-parent.

	Arnd
