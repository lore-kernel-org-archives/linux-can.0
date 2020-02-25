From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v1] can: mcp251x: Use readx_poll_timeout() helper
Date: Tue, 25 Feb 2020 22:08:44 +0100
Message-ID: <8fc817aa-6da1-f87c-85c8-72c3fef95020@pengutronix.de>
References: <20200217161038.25009-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35323 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgBYVIu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2020 16:08:50 -0500
In-Reply-To: <20200217161038.25009-1-andriy.shevchenko@linux.intel.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On 2/17/20 5:10 PM, Andy Shevchenko wrote:
> We may use special helper macro to poll IO till condition or timeout occurs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Added to linux-can-next/testing.

Tnx,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
