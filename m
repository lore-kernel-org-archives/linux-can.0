From: Dererk <dererk@debian.org>
Subject: Can support at Linux LXC?
Date: Fri, 20 Nov 2015 18:46:31 -0300
Message-ID: <564F94B7.2080603@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from sfa71.servidoraweb.net ([201.235.253.71]:48648 "EHLO
	nube.usla.org.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761135AbbKTVwG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2015 16:52:06 -0500
Received: from [127.0.0.1] (unknown [186.19.180.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by nube.usla.org.ar (Postfix) with ESMTPSA id 866972B6C41A
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2015 18:45:14 -0300 (ART)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi!

I'm playing with some bus CANs and linux LXC. But it seems that there
must be some kind of support missing on the LXC side.
Even vcan seems to have the very same results on it when trying to open
the socket:

socket(PF_CAN, SOCK_RAW, 1)             = -1 EAFNOSUPPORT (Address
family not supported by protocol)

Have you have any experience with this?


Is there a proper place where I could route this doubts at an
specialized mailing list on the linux kernel that you know might be more
appropiate?

Thanks in advance!


Cheers,

Dererk

-- 
BOFH excuse #449:
greenpeace free'd the mallocs


