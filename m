From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] slcan: Don't transmit uninitialized stack data in
 padding
Date: Wed, 1 Apr 2020 12:08:02 +0200
Message-ID: <bf943fd5-277f-075c-a4c7-d52c2c816e7a@pengutronix.de>
References: <20200401100639.20199-1-rpalethorpe@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52111 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgDAKIX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Apr 2020 06:08:23 -0400
In-Reply-To: <20200401100639.20199-1-rpalethorpe@suse.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Palethorpe <rpalethorpe@suse.com>, linux-can@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com, davem@davemloft.net

On 4/1/20 12:06 PM, Richard Palethorpe wrote:
> struct can_frame contains some padding which is not explicitly zeroed in
> slc_bump. This uninitialized data will then be transmitted if the stack
> initialization hardening feature is not enabled (CONFIG_INIT_STACK_ALL).
> 
> This commit just zeroes the whole struct including the padding.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Fixes: a1044e36e457 ("can: add slcan driver for serial/USB-serial CAN adapters")
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: linux-can@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: security@kernel.org
> Cc: wg@grandegger.com
> Cc: mkl@pengutronix.de
> Cc: davem@davemloft.net

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
