From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Thu, 23 Feb 2012 10:28:32 +0100
Message-ID: <4F4606C0.7010203@grandegger.com>
References: <4F44E640.8010708@grandegger.com>	<CANKRQnh-gF3ZAD9_uDrqd1Bu9F82fqNRAQLEwJCCD3rC6ScxRg@mail.gmail.com>	<4F45EE68.60304@grandegger.com> <CANKRQni7j0QEmcpY17A8R84CNvUJOKk9ahYAJ1h6N2hfbv-+tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53251 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab2BWJ2f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 04:28:35 -0500
In-Reply-To: <CANKRQni7j0QEmcpY17A8R84CNvUJOKk9ahYAJ1h6N2hfbv-+tQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, "bhupesh.sharma" <bhupesh.sharma@st.com>

On 02/23/2012 09:08 AM, Tomoya MORINAGA wrote:
> 2012=E5=B9=B42=E6=9C=8823=E6=97=A516:44 Wolfgang Grandegger <wg@grand=
egger.com>:
>> On 02/23/2012 01:13 AM, Tomoya MORINAGA wrote:
>>> 2012=E5=B9=B42=E6=9C=8822=E6=97=A521:57 Wolfgang Grandegger <wg@gra=
ndegger.com>:
>>>> Alexander, Tomoya, or anybody else, it would be nice if you could =
test
>>>> this patch and give some feedback. Thanks.
>>>
>>> Unfortunately, I'm involved another work, so I can't start soon.
>>
>> There is no hurry. I think it's good practice to first add the new
>> driver and declare the other as deprecated. Then, after some time, w=
e
>> can remove the deprecated driver safely.
>>
>=20
> OK. If there isn't hurry,
> we will do this. Maybe within 1 or 2 moths.

That's fine, thanks.

Wolfgang.
