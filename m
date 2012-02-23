From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Thu, 23 Feb 2012 10:27:09 +0100
Message-ID: <4F46066D.60601@grandegger.com>
References: <4F44E640.8010708@grandegger.com> <1626144.8BPv1GvbeG@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53214 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2BWJ1M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 04:27:12 -0500
In-Reply-To: <1626144.8BPv1GvbeG@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "bhupesh.sharma" <bhupesh.sharma@st.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>

Hi Alexander,

On 02/23/2012 09:27 AM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> Am Mittwoch, 22. Februar 2012, 13:57:36 schrieb Wolfgang Grandegger:
>> For maintenance reasons, this diver should replace the "pch_can" driver
>> sooner than later as it uses the same CAN controller core. I named it
>> "pch_pci". Maybe "pch_can" would be more appropriate (common). This
>> patch is for 2.6.39, but likely it applies fine also to more recent
>> versions of the Linux kernel.
>>
>> Alexander, Tomoya, or anybody else, it would be nice if you could test
>> this patch and give some feedback. Thanks.
> 
> What is the current state of c_can? Are there known bugs/issues?

Bhupes said that he has a series of changes for the C_CAN driver but I
don't know if they fix serious bugs. Apart from that, there are no
pending issues, IIRC.

Wolfgang.

