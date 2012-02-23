From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Thu, 23 Feb 2012 17:08:26 +0900
Message-ID: <CANKRQni7j0QEmcpY17A8R84CNvUJOKk9ahYAJ1h6N2hfbv-+tQ@mail.gmail.com>
References: <4F44E640.8010708@grandegger.com>
	<CANKRQnh-gF3ZAD9_uDrqd1Bu9F82fqNRAQLEwJCCD3rC6ScxRg@mail.gmail.com>
	<4F45EE68.60304@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41992 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab2BWII0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 03:08:26 -0500
Received: by pbcun15 with SMTP id un15so1145771pbc.19
        for <linux-can@vger.kernel.org>; Thu, 23 Feb 2012 00:08:26 -0800 (PST)
In-Reply-To: <4F45EE68.60304@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, "bhupesh.sharma" <bhupesh.sharma@st.com>

2012年2月23日16:44 Wolfgang Grandegger <wg@grandegger.com>:
> On 02/23/2012 01:13 AM, Tomoya MORINAGA wrote:
>> 2012年2月22日21:57 Wolfgang Grandegger <wg@grandegger.com>:
>>> Alexander, Tomoya, or anybody else, it would be nice if you could test
>>> this patch and give some feedback. Thanks.
>>
>> Unfortunately, I'm involved another work, so I can't start soon.
>
> There is no hurry. I think it's good practice to first add the new
> driver and declare the other as deprecated. Then, after some time, we
> can remove the deprecated driver safely.
>

OK. If there isn't hurry,
we will do this. Maybe within 1 or 2 moths.

thanks,

ROHM Co., Ltd.
tomoya
