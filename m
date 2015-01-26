From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: j1939 on v3.15
Date: Mon, 26 Jan 2015 20:27:49 +0100
Message-ID: <20150126192749.GF13826@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:54586 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbbAZTjd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 14:39:33 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: James Sarrett <jsarrett@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hey James,

I just put my v3.15 development branch on gitorious.
This has preliminary support for more recent kernels,
and addresses quite a few comments that Oliver Hartkopp made
quite some time ago.
I did not find the time to really clean up an squash some commits
together.
I've tested this since v3.12, which first exposed the problems with skb->sk
that you described. It seems that I successfully did address that issue.

I've had some questions about specific features since, and I'm looking to
implement those also. One example, that regularly pops up, is byte stuffing
for transport protocol.
Some other small features are in the pipeline.
This has forced me to refactor the skb->cb usage.

Please feel free to amend.
Kind regards,
kurt
