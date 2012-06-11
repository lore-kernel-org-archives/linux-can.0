From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v5] CAN FD support
Date: Mon, 11 Jun 2012 20:15:58 +0200
Message-ID: <4FD635DE.3080303@hartkopp.net>
References: <4FC3D9EE.4010807@hartkopp.net> <4FD60007.8070801@grandegger.com> <4FD62CBA.8050300@hartkopp.net> <4FD63307.7020605@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:15321 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab2FKSP5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Jun 2012 14:15:57 -0400
In-Reply-To: <4FD63307.7020605@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11.06.2012 20:03, Wolfgang Grandegger wrote:

> On 06/11/2012 07:36 PM, Oliver Hartkopp wrote:


>> it was nearly 16 month the PF_CAN infrastructure was part of the mainline
>> kernel until the first 'real' CAN drivers have been added to the tree.
>> Meanwhile the driver development inside and outside the tree had a stable
>> environment for APIs and testing.
> 
> Ah, I forgot, the vcan driver allows to test the CAN FD interface as
> well, basically ==> the code is tested to some extend which calms me
> down ;).


Yes. After some development and also removal of new ugly code it looks pretty
simple and clear now. And it was also easy to test (using new applications
with the older kernel too).

Especially it allowed some simplifications in the kernel code and the adaption
of userspace applications was amazingly simple. See my commits in
hartkopps-can-utils ...


>>
>>> More later...
>>
>>
>> Reviews are welcome.
>> Please check the different postings and discussions up to v5 before.
> 
> Well, I'm just back from holiday...


Welcome back :-)

Oliver
