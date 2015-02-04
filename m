From: Mike Purvis <mpurvis@clearpathrobotics.com>
Subject: Re: Standard CAN over IP
Date: Wed, 4 Feb 2015 16:38:06 -0500
Message-ID: <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
 <54D284B4.5050501@uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60590 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbbBDVi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Feb 2015 16:38:27 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so5491471ier.10
        for <linux-can@vger.kernel.org>; Wed, 04 Feb 2015 13:38:27 -0800 (PST)
In-Reply-To: <54D284B4.5050501@uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Armin Burchardt <armin@uni-bremen.de>
Cc: linux-can@vger.kernel.org

Armin=E2=80=94

=46antastic, thanks for the pointer, this is just what I was looking
for. I've given it a quick try, and the binary in Ubuntu 14.04's
can-utils package appears to do what I want in terms of creating a net
device.

=46or future travellers, the protocol is documented in the slcan.c
source file, from the kernel tree:

https://github.com/torvalds/linux/blob/master/drivers/net/can/slcan.c#L=
103

The slcand program is a very thin setup utility that ultimately just
busy-waits, while the N_SLCAN line discipline on the TTY does all the
work.

Thanks again,

Mike

On 4 February 2015 at 15:44, Armin Burchardt <armin@uni-bremen.de> wrot=
e:
> Hi Mike,
>
> On 04.02.2015 21:27, Mike Purvis wrote:
>> system as a socketcan can0 device. Is there some standard component
>> which already does this, or at least some tooling around serializing
>> CAN messages to a bytestream?
>
> there is slcand (UART to socketcan from the can-utils package) to use
> serial CAN adapters with socketcan. Implementing the (line based)
> protocol in the mcu should not be too hard.
>
> Armin (switching back to read-only mode)
>
