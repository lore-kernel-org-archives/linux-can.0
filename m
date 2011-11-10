From: Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Thu, 10 Nov 2011 11:58:29 +0100
Message-ID: <CAKvQZ_0WOytf11ubFYTHiF7=C1x-R2cHXkp0dnv9w_DM6j4quw@mail.gmail.com>
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
	<CAKvQZ_1A5H_wDjnmvd5bDmtXvAyL3XNy6HesPR6jGzisoUe8eA@mail.gmail.com>
	<4EBB8FDC.40704@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4EBB8FDC.40704-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
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

2011/11/10 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
> On 11/10/2011 09:39 AM, Willy Lambert wrote:
>> 2011/11/10 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
>>> Hi Willy,
>>>
>>> On 11/09/2011 07:03 PM, Willy Lambert wrote:
>>>> 2011/9/5 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
>>> ...
>>>>> Ah, at a closer look, the PC/104-Plus is an extension of the PC/104 from
>>>>> factor with an additional connector for PCI. It therefore still supports
>>>>> ISA bus communication, which the IXXAT PC-I 04/104 board uses.
>>>>>
>>>>> Therefore I'm going to prepare a patch removing the "X86_32" restriction
>>>>> for CONFIG_ISA above. Sorry for confusion.
>>>>>
>>>>
>>>> May I bump this up ? I read your conversation on other linux ML, but I
>>>> don't really know how it ended.
>>>
>>> Some time ago I posted a patch to the relevant mls removing the
>>> restriction mentioned above. But enabling CONFIG_ISA also for x86_64
>>> systems is not wished mainly to avoid the expected mess with old
>>> legacy ISA driver code. Therefore we should convert the driver to a
>>> platform driver. I have attached the *untested* patch below. Could you
>>> please give it a try? If it works fine, I will send it finally to the
>>> netdev ml.
>>>
>>
>> For sure I'll do. But it'll take some time because switching from 32b to 64b.
>
> OK, please test first on 32b and let me know. Then I'm quite sure that
> it will also work on 64b.
>
> Wolfgang.
>

Oh sorry I didn't realized (even if it was obvious in the end) it was
also working on a 32b system. I test this as soon as my former driver
is working (cf the other thread)
