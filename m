From: "Kvaser Support" <support@kvaser.com>
Subject: Re: (Case 14420) Kvaser socketCAN support
Date: Sun, 04 May 2014 08:00:57 +0200
Message-ID: <5365d799.0838e00a.4261.ffffb959@mx.google.com>
References: <20140503131816.GA29125@thinkoso.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50068 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaEDGA6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 4 May 2014 02:00:58 -0400
Received: by mail-qa0-f46.google.com with SMTP id w8so5993598qac.33
        for <linux-can@vger.kernel.org>; Sat, 03 May 2014 23:00:58 -0700 (PDT)
In-Reply-To: <20140503131816.GA29125@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "Adams, Shawn - 0999 - MITLL" <shawn.adams@ll.mit.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>

Hi guys,

Some, but not all, versions of older firmware are available on the down=
load page of the website, just click the Older versions link on the spe=
cific download. If you need another version than available, just let me=
 know and I'll post it.

Best regards
Jerry Thors=E9n
Kvaser Support
support@kvaser.com
-----------------------------------------------------------------------=
----



-----Original Message-----
=46rom: "Olivier Sobrie" <olivier@sobrie.be>
Reply-To: "Olivier Sobrie" <olivier@sobrie.be>
Date: Sat, 3 May 2014 15:18:16 +0200
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Adams, Shawn - 0999 - =
MITLL" <shawn.adams@ll.mit.edu>, "linux-can@vger.kernel.org" <linux-can=
@vger.kernel.org>, "Kvaser Support (support@kvaser.com)" <support@kvase=
r.com>
Subject: Re: Kvaser socketCAN support

>Hello Christopher,
>
>On Fri, May 02, 2014 at 10:19:02AM -0400, Smith, Christopher - 0999 - =
MITLL wrote:
>> Sorry for the mix up to the Olivers.  I should have paid closer atte=
ntion!
>> The only thing I can figure at this point is something about the new
>> firmware breaks the driver.  We've tried on a few machines and get t=
he same
>> error.  I also upgraded to device firmware 3.2.302 and see the same =
thing.
>> I'm not sure how to downgrade the firmware as kvaser doesn't post th=
ose
>> binaries. =20
>>=20
>> As for the kernel version, we're running 3.12.0 so I believe you're =
saying
>> that does include the fix?
>
>Yes this version includes the fix.
>
>Is it possible for you to take a wireshark capture on the usb bus when
>the probing of the device is made by the kvaser_usb driver?
>Can you also check if the device is correclty probed by the Kvaser lea=
f
>driver, i.e. the one you can find on the kvaser website?
>
>Thanks,
>
>--=20
>Olivier
