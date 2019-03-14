From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
Date: Thu, 14 Mar 2019 14:19:42 +0100
Message-ID: <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
 <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
 <20190314120047.GA19072@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190314120047.GA19072@amd>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 14/03/2019 13.00, Pavel Machek wrote:
linux,default-trigger from
> 
> Yeah and now insert the modules for the can devices in different
> order... May not happen in your case but will be fairly common for
> ethernets.

Unpredictable device names is not a problem I'm trying to solve, nor one
that actually occurs on embedded systems. And even if one has such a
system, one is likely running udev or similar to rename devices to
something sane and predictable, in which case a fixed string _still_
works fine. Or one uses udev rules to munge the netdev trigger sysfs
files, and has applications dealing with devices appearing as banana457.

OK, so there's of_find_net_device_by_node, so a phandle solution might
also be possible, and might work just as well for my case. But I still
think initializing with a fixed string is the simplest and sanest thing
to do.

Rasmus
