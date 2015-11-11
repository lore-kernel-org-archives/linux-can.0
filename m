From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: can-j1939: semantics question
Date: Wed, 11 Nov 2015 20:52:55 +0100
Message-ID: <20151111195255.GB23275@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:45565 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKKTxn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2015 14:53:43 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>

Hey,

I eventually got into investigating the necessary changes to drop
iproute2 from can-j1939.
We somewhat agreed that opening a can-j1939 socket and binding
to a CAN interface should activate can-j1939 processing for that
interface.
But how about deactivation?
Should the last can-j1939 socket on a CAN iface deactivate can-j1939 for
that iface when that socket closes?

Kind regards,
Kurt
