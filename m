From: Jean-Claude Monnin <jc_monnin@emailplus.org>
Subject: Re: CAN j1939 library doubts
Date: Wed, 13 Mar 2013 09:29:01 +0100
Message-ID: <854F9BFD-752B-4B2B-A637-7310BCF8B7D2@emailplus.org>
References: <loom.20130312T213038-40@post.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38335 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab3CMI3E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 13 Mar 2013 04:29:04 -0400
In-Reply-To: <loom.20130312T213038-40@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Giox79 <giovanniparodi79@gmail.com>
Cc: linux-can@vger.kernel.org

Hi,
Yes, I have been using j1939 on an ARM system in the past (TI AM3505). Requires a patched kernel, "iproute2" and "can-j1939-utils". jspy worked fine on ARM.
I cross-compiled the software with ptxdist. I can't provide a tutorial for that, but I can share the rules to build it in case you are familiar with ptxdist.
I would like take the opportunity to say that I encourage the effort to bring upstream the j1939 stack and it's tools. Official tar.* source archives for "iproute2" with j1939 support and "can-j1939-utils" would be useful for the ptxdist rules.
Regards,
Jean-Claude

On Mar 12, 2013, at 22:52 , Giox79 <giovanniparodi79@gmail.com> wrote:

> Hello everybody.
> I'm working on an embedded system, and I would like to dump data 
> from CAN bus and parse j1939 data. 
> I built canutils, last version, on ARM device, however, I'm a bit 
> about how to use the j1939 version of canutils.
> Is there any tutorial about what should I do in order to use 
> Utilities  like jspy?
> If I'm right, I have to build both the kernel and the user app section.
> I'm a Linux beginner, and I didn't find guides to these steps.
> Any help, link to website or similar resources will be really appreciated.
> 
> Finally is there anyone that compiled the j1939 can libraries on 
> ARM systems?
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

