From: Wei Liu <wei.liu2@citrix.com>
Subject: Re: [PATCH 4/4] drivers/net: Use octal not symbolic permissions
Date: Mon, 26 Mar 2018 15:07:27 +0100
Message-ID: <20180326140727.4aripztdc2ar6g45@citrix.com>
References: <cover.1521845235.git.joe@perches.com>
 <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jean-Paul Roubelat <jpr@f6fbb.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Mackerras <paulus@samba.org>, Michal Ostrowski <mostrows@earthlink.net>, Oliver Neukum <oliver@n>
List-Id: linux-can.vger.kernel.org

On Fri, Mar 23, 2018 at 03:54:39PM -0700, Joe Perches wrote:
> Prefer the direct use of octal for permissions.
> 
> Done with checkpatch -f --types=SYMBOLIC_PERMS --fix-inplace
> and some typing.
> 
> Miscellanea:
> 
> o Whitespace neatening around these conversions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/xen-netback/xenbus.c       |  4 +-
>  drivers/net/xen-netfront.c             |  6 +--

Reviewed-by: Wei Liu <wei.liu2@citrix.com>
