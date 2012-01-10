From: Felix Obenhuber <felix@obenhuber.de>
Subject: Possible bug in ac_msg_is_request_for_ac
Date: Tue, 10 Jan 2012 13:34:08 +0100
Message-ID: <1326198848.2189.9.camel@osblap120.dev.osb-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:52114 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab2AJMeK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 07:34:10 -0500
Received: by wibhm6 with SMTP id hm6so3346137wib.19
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2012 04:34:09 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Kurt,

just wondered about the last line in ac_msg_is_request_for_ac
https://gitorious.org/~kurt-vd/linux-can/can-j1939-modules/blobs/master/net/can/j1939/address-claim.c

static inline int ac_msg_is_request_for_ac(struct sk_buff *skb)
{
        [...]
	req_pgn = skb->data[0] | (skb->data[1] << 8) | (skb->data[2] << 16);
	return req_pgn = PGN_ADDRESS_CLAIMED;
                    ^^^^^^

Think here's a equal sign missing cause you always return
PGN_ADDRESS_CLAIMED.

Cheers,

Felix
              



