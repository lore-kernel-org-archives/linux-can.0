From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8 devices
Date: Mon, 03 Dec 2012 09:15:01 +0100
Message-ID: <50BC5F85.30300@grandegger.com>
References: <50BB1E8E.10809@universalnet.at> <50BB592B.4030604@grandegger.com> <50BBF5CA.500@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37695 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab2LCIPT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 03:15:19 -0500
In-Reply-To: <50BBF5CA.500@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

On 12/03/2012 01:43 AM, krumboeck@universalnet.at wrote:
> Am 2012-12-02 14:35, schrieb Wolfgang Grandegger:
>> Hi Bernd,
>>
>> nice to see this driver being pushed mainline. As Oliver already pointed
>> out, there are a few general naming and coding style issues:
>>
>> - The preferred multi line comment styles is:
>>
>>    /*
>>     * A Comment
>>     */
> 
> The Script checkpatch.pl didn't like this comment style. I'll change it
> again.
> 
>>
>> - The patch does not yet apply to David Millers "net-next" GIT tree.
>>    There are problems with Kconfig and Makefile.
> 
> I assume this is the right command and repository url:
> git clone
> "http://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git"

Yes. You may want to add
"--reference=<a-recent-local-linux-kernel-git-tree>" to save bandwidth
and space.

Wolfgang.


