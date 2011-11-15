From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Tue, 15 Nov 2011 13:36:51 +0100
Message-ID: <4EC25CE3.4000404@grandegger.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>	<4E653775.4030503@grandegger.com>	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>	<4EBB8CFD.3050602@grandegger.com>	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>	<CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>	<4EBEE043.6070601@grandegger.com>
	<4EBEE1D8.7040407@grandegger.com>	<CAKvQZ_1QmJAPUZAEvV-2FSo2HR4byApoEqWPnOts9up90U4BVg@mail.gmail.com>	<CAKvQZ_3anOf1SbE5TK6gvJf4v3gw1MBae0hw5JGr__szt7KoQQ@mail.gmail.com>	<4EC01B12.5050404@grandegger.com>
	<4EC0E4BE.4010101@grandegger.com>	<CAKvQZ_2GkTqFrp-9quut0f33KL9tdD9NSTZ3btDHLZNP=a2VwQ@mail.gmail.com>	<4EC13191.6070901@grandegger.com>	<CAKvQZ_24-FqBHcyZAtf+kR26TaU-Uhji50Q6uQUvOiM=txPCiQ@mail.gmail.com>	<4EC21D95.5070508@grandegger.com>
	<CAKvQZ_2YrdYiq1_wge1zgyyDQws4+mn02+iZ-E5jgaqTma_3dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <CAKvQZ_2YrdYiq1_wge1zgyyDQws4+mn02+iZ-E5jgaqTma_3dw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On 11/15/2011 01:28 PM, Willy Lambert wrote:
> 2011/11/15 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
...
>>> Do you wish any further tests ?
>>
>> Does the following command work as well?
>>
>>  modprobe sja1000_isa irq=10,10 mem=0xD0000,0xD0200 ocr=0x5e cdr=0
>>
>> Does re-loading of the driver work properly?
>>
>>  rmmod sja1000_isa; insmod sja1000_isa ...
>>
> 
> all this is working.

Good.

>> Similar tests on a x86_64 system and with a recent kernel version would
>> be nice to have.
>>
>> Thanks,
> 
> This is not possible a present time, I don't have any 64b img to put
> on my board and I don't have the time to create a new one. Sorry.

OK, no problem. I'm already confident enough to push this patch mainline.

Thanks for your effort.

Wolfgang.
