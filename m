From: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Subject: Losing CAN messages with socket-CAN
Date: Mon, 08 Apr 2013 16:43:48 +0200
Message-ID: <20130408144348.E9EDED0DAE4C7@bmail02.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webmail-out1.one.com ([91.198.169.16]:47641 "EHLO
	webmail-out1.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965144Ab3DHOnu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Apr 2013 10:43:50 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Wolfgang and Kurt,

Thanks for your responses. I intend to collect the requested information, and also to improve the errorno reporting. Unfortunatelly I need to fix some problems in the higher level SW first and also to improve error recovery in case a CAN message gets lost.

We just had a short discussion with project management, and we agreed that I will dig into it and spend some effort to get a CAN driver working on the EG20T. Up to now I approached the driver as ready-to-use, now I will appoach it as under-development.

I expect to post information/code/questions before the end of the week again.

Best regards,

Jeroen Lammertink