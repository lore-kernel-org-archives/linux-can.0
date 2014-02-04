From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: AW: netlink error -95 (Operation not supported) with can-utils/cangw
Date: Tue, 4 Feb 2014 17:03:08 +0100
Message-ID: <CAGm1_kstmWLjejYMy3Sd2jUpzdUv5o5OT+9VvfA=MOTbxTWx2Q@mail.gmail.com>
References: <18F8639CFC8C7C4D819AB347808079D4026C69FC@pluto.office.rac.de>
 <52F0D101.6050500@hartkopp.net> <18F8639CFC8C7C4D819AB347808079D4026C6A12@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:64171 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbaBDQDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2014 11:03:31 -0500
Received: by mail-bk0-f48.google.com with SMTP id ej10so3369504bkb.35
        for <linux-can@vger.kernel.org>; Tue, 04 Feb 2014 08:03:29 -0800 (PST)
In-Reply-To: <18F8639CFC8C7C4D819AB347808079D4026C6A12@pluto.office.rac.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sandro Anders | CarMedialab <sandro.anders@carmedialab.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Sandro,

you could cangw description here: http://elinux.org/Can-utils as soon
as you sort the things out.

Regards,
Yegor

On Tue, Feb 4, 2014 at 1:02 PM, Sandro Anders | CarMedialab
<sandro.anders@carmedialab.com> wrote:
> Hi Olli,
>
> Hmm it wasn't clear to me that an additional module is necessary for =
using this feature. But anyway this explains the behaviour. Is there an=
y documentation? I couldn't find anything about can-gw in the can.txt f=
ile.
>
> Many thanks to you and best regards,
> Sandro
>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
>> owner@vger.kernel.org] Im Auftrag von Oliver Hartkopp
>> Gesendet: Dienstag, 4. Februar 2014 12:38
>> An: Sandro Anders | CarMedialab; linux-can@vger.kernel.org
>> Betreff: Re: AW: netlink error -95 (Operation not supported) with ca=
n-
>> utils/cangw
>>
>> Hi Sandro,
>>
>> did you load the can-gw module?
>>
>> When can-gw is not loaded the netlink functions for cangw are not
>> registered.
>>
>> Regards,
>> Oliver
>>
>> On 04.02.2014 11:55, Sandro Anders | CarMedialab wrote:
>> > Hi all,
>> >
>> > I was able to compile the can-utils/* apps without any errors and =
the
>> > most are working. But if I call the cangw command I get the follow=
ing
>> > error message: cangw -A -s can1 -d can3
>> > netlink error -95 (Operation not supported)
>> >
>> > Both CAN's are up and running. My assumption is that there is some
>> > netlink support missing in my Kernel, isn't it? Thanks for your he=
lp.
>> >
>> > Sandro
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-ca=
n" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
