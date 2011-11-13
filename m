From: Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Sun, 13 Nov 2011 10:15:19 +0100
Message-ID: <CAKvQZ_3anOf1SbE5TK6gvJf4v3gw1MBae0hw5JGr__szt7KoQQ@mail.gmail.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>
	<4E4CA945.7080504@hartkopp.net> <4E4CC9D5.6040708@pengutronix.de>
	<CAKvQZ_0raVFUsCFYA2FVH_138DCMw6ipKHdz=Dh62K4YpM5o=Q@mail.gmail.com>
	<4E5CCAA5.4030009@grandegger.com>
	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>
	<4E6271CD.6040407@grandegger.com>
	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>
	<4E64B6CB.8010505@grandegger.com>
	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>
	<4E653775.4030503@grandegger.com>
	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>
	<4EBB8CFD.3050602@grandegger.com>
	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>
	<CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>
	<4EBEE043.6070601@grandegger.com> <4EBEE1D8.7040407@grandegger.com>
	<CAKvQZ_1QmJAPUZAEvV-2FSo2HR4byApoEqWPnOts9up90U4BVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <CAKvQZ_1QmJAPUZAEvV-2FSo2HR4byApoEqWPnOts9up90U4BVg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

2011/11/13 Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> 2011/11/12 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
>> On 11/12/2011 10:08 PM, Wolfgang Grandegger wrote:
>>> On 11/12/2011 10:55 AM, Willy Lambert wrote:
>> ...
>>>>> I failed to apply the patch, is it for 2.6.38.8 kernels ?
>>>
>>> No, it's for up-to-date *mainline* linux version 3.1.x. Any chance to
>>> switch to David Miller's "net-nex-2.6" tree?. Otherwise I'm going to
>>> adapt the patch to 2.6.38.8.
>>
>> Well, the patch also applies to 2.6.38.8. Maybe you have some problems
>> extracting the patch. Therefore I have attached it as attachment this
>> time. Good luck.
>
> It's ok now :
> ard@ard-host:~/src/linux-2.6.38.8$ patch -p1 < wg_platform.patch
> patching file drivers/net/can/sja1000/Kconfig
> patching file drivers/net/can/sja1000/sja1000_isa.c
>
> I must have done something wrong. I am going to test it now
>

arg, it doesn't compile I had a look a sources but I don't see the error :

  CC [M]  drivers/xenomai/can/rtcan_raw_dev.o
drivers/net/can/sja1000/sja1000_isa.c: In function =91sja1000_isa_init=92:
drivers/net/can/sja1000/sja1000_isa.c:297: error: invalid storage
class for function =91sja1000_isa_exit=92
drivers/net/can/sja1000/sja1000_isa.c:296: warning: ISO C90 forbids
mixed declarations and code
drivers/net/can/sja1000/sja1000_isa.c:307: error: invalid storage
class for function =91__inittest=92
drivers/net/can/sja1000/sja1000_isa.c:307: warning: =91alias=92 attribute i=
gnored
drivers/net/can/sja1000/sja1000_isa.c:308: error: invalid storage
class for function =91__exittest=92
drivers/net/can/sja1000/sja1000_isa.c:308: warning: ISO C90 forbids
mixed declarations and code
drivers/net/can/sja1000/sja1000_isa.c:308: warning: =91alias=92 attribute i=
gnored
drivers/net/can/sja1000/sja1000_isa.c:308: error: expected declaration
or statement at end of input
make[5]: *** [drivers/net/can/sja1000/sja1000_isa.o] Error 1



>
>>
>> Wolfgang.
>>
>
