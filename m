From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
Date: Sun, 24 Mar 2019 20:39:24 +0000
Message-ID: <9a01fe8a-c083-c552-faed-c0f2c6b1e818@prevas.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
 <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
 <20190314120047.GA19072@amd>
 <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
 <20190317191150.GA31285@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190317191150.GA31285@amd>
Content-Language: en-US
Content-ID: <63A46BBF82393944951908A8175FD055@EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: =?Windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On 17/03/2019 20.11, Pavel Machek wrote:
> On Thu 2019-03-14 14:19:42, Rasmus Villemoes wrote:
>> On 14/03/2019 13.00, Pavel Machek wrote:
>> linux,default-trigger from
>>>
> Udev will not help with renaming -- it runs after kernel boot, while
> udev parsing is usually done before userland starts.

This is simply plain wrong. The netdev trigger explicitly tracks a
netdevice _by name_, and has netdev notifier in place to get notified
should a netdevice by that name ever appear.

> Plus, device tree should really describe hardware, and be usable with
> other operating systems. Of course, there are exceptions, but "can0"
> is unneccessarily linux-specific.

And "linux,netdev-trigger" is not linux-specific? And why are you so
hung up on the can example, it would work just as fine for usb0 or whatever=
.

Anyway, to whoever is responsible for merging this stuff, please at most
apply patch 1, factoring out the string-to-netdev handling doesn't make
much sense without the final configure-from-dt stuff.

Rasmus
