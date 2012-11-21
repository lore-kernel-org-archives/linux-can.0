From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 16:56:48 +0100
Message-ID: <50ACF9C0.8050206@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or
 g> <loom.20121121T162041-774@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46977 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2KUP4v (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 10:56:51 -0500
In-Reply-To: <loom.20121121T162041-774@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/21/2012 04:25 PM, Michael Pellegrini wrote:
> Michael Pellegrini <mikep86 <at> gmail.com> writes:
> 
>> This driver is working very well so far.  ifconfig shows that I am sending and
>> receiving CAN messages successfully.  This is confirmed externally by the CAN
>> Monitor system.
>>
>> I will start a more intensive test now and report the results.
> 
> I shouldn't have spoken so soon.  Running my application on the PCH-System
> caused the original problem within minutes.  Message transmission stopped
> and and my application started printing the error "No buffer space available".
> The only way to recover was to reset the interface.

OK, at least we have reached the level of the PHC_CAN driver. The driver
does print some debug messages. Could you show them?

Wolfgang.


