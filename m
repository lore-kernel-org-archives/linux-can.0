From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: PEAK CAN USB driver patch
Date: Fri, 09 Dec 2011 19:58:12 +0100
Message-ID: <4EE25A44.8020800@hartkopp.net>
References: <201112091421.pB9ELIvL003552@post.webmailer.de> <4EE24089.5090300@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:14025 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab1LIS6T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Dec 2011 13:58:19 -0500
In-Reply-To: <4EE24089.5090300@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Michael Maidhof <m.maidhof@peak-system.com>, "Uwe Wilhelm (PEAK-System)" <u.wilhelm@peak-system.com>

On 09.12.2011 18:08, Grosjean Stephane wrote:

> Hi Oliver,
> 
> Please find below the patch to apply to linux-can-next, which adds support for
> the PEAK System CAN USB adapters.


Whow - thanks!

I already transferred your original patch into my tree by hand :-)

And the first thing i stumble when compiling was here:

> diff --git a/drivers/net/can/usb/pcan_usb.c b/drivers/net/can/usb/pcan_usb.c
> new file mode 100644
> index 0000000..eb2329d
> --- /dev/null
> +++ b/drivers/net/can/usb/pcan_usb.c
> @@ -0,0 +1,740 @@
> +/*
> + * CAN driver for PEAK System PCAN-USB adapter
> + *
> + * Copyright (C) 2011-2012 PEAK-System GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>


here

#include <linux/module.h>

is missing to expand this:

> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");

> new file mode 100644
> index 0000000..c81b42d
> --- /dev/null
> +++ b/drivers/net/can/usb/pcan_usb_pro.c
> @@ -0,0 +1,1426 @@
> +/*
> + * CAN driver for PEAK System PCAN-USB-PRO adapter
> + *
> + * Copyright (C) 2011-2012 PEAK-System GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +#include <linux/stringify.h>



here

#include <linux/module.h>

is missing to expand this:

> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB-PRO adapter");


More remarks following soon ...

Have a nice weekend,

Oliver

