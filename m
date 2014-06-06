From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: Re: linux-can ISOTP module
Date: Fri, 6 Jun 2014 08:42:32 +0200
Message-ID: <CAA7hF3xomuS-mDRQWmkC=D9YfbDPt+TwXKc7+ZFtUNwkg5cMdQ@mail.gmail.com>
References: <loom.20140604T144601-350@post.gmane.org>
	<538F6836.3060508@hartkopp.net>
	<CAA7hF3w-W1E0E5M4Gkc=0aYB0NQPrOMJfLp-iSG8K8HJU-sdoA@mail.gmail.com>
	<539043EA.6030001@artisandeveloppeur.fr>
	<5390B575.7030506@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:49463 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaFFGmc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Jun 2014 02:42:32 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so3570935qga.28
        for <linux-can@vger.kernel.org>; Thu, 05 Jun 2014 23:42:32 -0700 (PDT)
In-Reply-To: <5390B575.7030506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: maxime@artisandeveloppeur.fr, linux-can@vger.kernel.org

Hello,

On Thu, Jun 5, 2014 at 8:22 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hello Maxime and Laurent,
>
> On 05.06.2014 12:18, Maxime Jayat wrote:
>
>>> Ok, with isotp.h api, i understand that we can parameter block size, stmin,
>>> wftmax, transmission time (n_ax), padding.
>>> But how can i specify the timing n_CS (time between flow control reception
>>> and first consecutive frame) and the timing n_BS (time between first frame
>>> reception and flow control emission)? In the same way, is it possible to
>>> specify according timeout (n_BR for flow control timeout reception, and n_CR
>>> for consecutive frame timeout reception)?
>
> Hm - didn't know that n_CS is important at all ...
> I'll take a look, if this can be integrated easily.
>
Most of the time, this timings are not critical, but when you want to
mke some diagnostic on a large panel of ECU, there is allways one who
has some particularity. I had some problem with some ECUs who didn't
send consecutive frame because i was sending the flow control too
fast. In this case, n_BS has to be parametrable.

>>>>>
>>>>> For extended adressing method, it seems that both rx and tx frame must have
>>>>> the same first byte in can frame (the one set by ext_address field of the
>>>>> structure). This is correct for mixed addressing method (see Iso15765-2),
>>>>> but for extended adressing method, we should be able to specify different
>>>>> Target and source adress. I have not seen anything like this.
>>>>
>>>> One socket represents one virtual 1:1 connection (defined by two CAN
>>>> identifiers and optional with one address extension) on the CAN bus.
>>>>
>>>> If you want to receive from different sources just create different sockets
>>>> (and e.g. use select() to listen to many open socket file descriptors).
>>>>
>>>> The protocol engine has always to answer with the correct address information.
>>>>
>>> With this method, how can i have a segmented transfer like this:
>>> 0x6a7  0x55 0x10 0x08 ........
>>> 0x687  0xAA 0x30 0x00 0x00
>>> 0x6a7  0x55 0x21 .....
>>>
>>> The connection i need is between two ECU, using IDs 0x6a7/687 and one has
>>> adress extension 0x55, the other 0xAA (this adressing method is used on some
>>> FIAT ECUs for example), but i don't see how it can work using two socket.
>> I confirm.
>> This is a problem that we also encountered on a BMW ECU with the current
>> implementation of ISOTP.
>> The use-case is real and not currently supported.
>
> Ooops!
>
> I've never read anything about an address extension used this way.
> Despite the fact that this is used at FIAT and BMW - can this be found
> somewhere in the protocol specification??
>
>> I had to hack isotp.c, adding a socket option to be able to choose an
>> address extension for the reception. Probably not the best solution but
>> it worked.
>
> I wonder if it would work to just add an rx address extension u8 element to
> struct can_isotp_options:
>
> struct can_isotp_options {
>
>         __u32 flags;            /* set flags for isotp behaviour.       */
>                                 /* __u32 value : flags see below        */
>
>         __u32 frame_txtime;     /* frame transmission time (N_As/N_Ar)  */
>                                 /* __u32 value : time in nano secs      */
>
>         __u8  ext_address;      /* set address for extended addressing  */
>                                 /* __u8 value : extended address        */
>
>         __u8  txpad_content;    /* set content of padding byte (tx)     */
>                                 /* __u8 value : content on tx path      */
>
>         __u8  rxpad_content;    /* set content of padding byte (rx)     */
>                                 /* __u8 value : content on rx path      */
>
>         __u8  rx_ext_address;   /* set address for extended addressing  */
>                                 /* __u8 value : extended address        */
>
> };
>
> /* flags for isotp behaviour */
>
> #define CAN_ISOTP_LISTEN_MODE   0x001   /* listen only (do not send FC) */
> #define CAN_ISOTP_EXTEND_ADDR   0x002   /* enable extended addressing */
> #define CAN_ISOTP_TX_PADDING    0x004   /* enable CAN frame padding tx path */
> #define CAN_ISOTP_RX_PADDING    0x008   /* enable CAN frame padding rx path */
> #define CAN_ISOTP_CHK_PAD_LEN   0x010   /* check received CAN frame padding */
> #define CAN_ISOTP_CHK_PAD_DATA  0x020   /* check received CAN frame padding */
> #define CAN_ISOTP_HALF_DUPLEX   0x040   /* half duplex error state handling */
> #define CAN_ISOTP_FORCE_TXSTMIN 0x080   /* ignore stmin from received FC */
> #define CAN_ISOTP_FORCE_RXSTMIN 0x100   /* ignore CFs depending on rx stmin */
> #define CAN_ISOTP_RX_EXT_ADDR   0x200   /* different rx extended addressing */
>
>
> pahole can-isotp.ko says:
>
> struct can_isotp_options {
>         __u32                      flags;                /*     0     4 */
>         __u32                      frame_txtime;         /*     4     4 */
>         __u8                       ext_address;          /*     8     1 */
>         __u8                       txpad_content;        /*     9     1 */
>         __u8                       rxpad_content;        /*    10     1 */
>
>         /* size: 12, cachelines: 1, members: 5 */
>         /* padding: 1 */
>         /* last cacheline: 12 bytes */
> };
>
> So this could be a working extension ...

In my opinion, it would be better to have all normalization parameters
in the structure:
__u8 Adressing_method
__u8 TA
__u8 SA
__u8 AE

Because depending on the Adressing method used, you have to use TA
(target adress) and SA (Source Adress) for first byte of the frame (TA
in emission, SA in reception) or AE (adress extension) for both
emission and reception (case of mixed adressing, see ISO15765-2
normalization)
But i don't know if it is available, due to compatibility.

Maybe i will have to work on this topic in the following weeks
(depending on some higher enterprise decision), so if i have some
patch i will send you.

>
> Regards,
> Oliver
>
>
Regards
Laurent
