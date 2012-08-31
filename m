From: Andrew Bell <andrew.bell.ia@gmail.com>
Subject: Re: Full Buffers and the Passive bus
Date: Fri, 31 Aug 2012 11:53:22 -0500
Message-ID: <CACJ51z3u_fond2B76eN_VayTfxr=RQz=t0AJA9Y-ouxz5Zvw+A@mail.gmail.com>
References: <CACJ51z3wGmSnZ3U-qe_QLSPnNuRb54k5=5zuQ+DBQ0aFohcvVw@mail.gmail.com>
	<5040EAFE.9000500@hartkopp.net>
	<CACJ51z35dnc7udK2AaYxRrf6vgZLvC=V-Weuf8TokTL0=3nAbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56515 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab2HaQxX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Aug 2012 12:53:23 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so5896782obb.19
        for <linux-can@vger.kernel.org>; Fri, 31 Aug 2012 09:53:22 -0700 (PDT)
In-Reply-To: <CACJ51z35dnc7udK2AaYxRrf6vgZLvC=V-Weuf8TokTL0=3nAbA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org

On Fri, Aug 31, 2012 at 11:52 AM, Andrew Bell <andrew.bell.ia@gmail.com> wrote:
> On Fri, Aug 31, 2012 at 11:49 AM, Oliver Hartkopp
> <socketcan@hartkopp.net> wrote:
>> On 31.08.2012 18:36, Andrew Bell wrote:
>>
>>> Is there some way within socket CAN to detect the state when no nodes
>>> are on the BUS?  I do get CAN_ERR_TX_TIMEOUT error frames after some
>>> time, but I'm writing to the BUS faster than frames drain from the
>>> buffers, so eventually buffers fill up and writes start failing.  In
>>> this case, write does return ENOBUFS.  But I'd like to be able to
>>> differentiate between the case where buffers are full because of some
>>> transient condition (I'm writing too fast for the BUS) and the
>>> condition when nobody is home to receive anything at all.
>>>
>>> Suggestions appreciated.
>>
>>
>> Hello Andrew,
>>
>> this first idea was to check, if the successful transmissions increase the tx
>> counter in the netdevice statistics. When there's no increasing value no
>> frames have been sent on the wire.
>
> Thanks for the idea.
>
> What is the interface/API for getting these statistics?
>
> --
> Andrew Bell
> andrew.bell.ia@gmail.com



-- 
Andrew Bell
andrew.bell.ia@gmail.com
