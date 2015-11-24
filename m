From: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Subject: SocketCAN timestamps
Date: Tue, 24 Nov 2015 14:07:10 +0100
Message-ID: <565460FE.7060401@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.sevenbyte.org ([5.9.90.188]:59824 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbbKXN0e (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 24 Nov 2015 08:26:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sevenbyte.org (Postfix) with ESMTP id BED371260216
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2015 14:07:16 +0100 (CET)
Received: from mail.sevenbyte.org ([127.0.0.1])
	by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bjpdAKupQC3X for <linux-can@vger.kernel.org>;
	Tue, 24 Nov 2015 14:07:11 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I did some google work to find out how to retrieve timestamps of
received messages. I have found this:

http://socket-can.996257.n3.nabble.com/PATCH-Add-timestamps-description-to-can-txt-td1430.html

It seems that this patch has never been applied to the kernel tree. Are
there any reasons (besides being forgotten) for this?

Stefan
