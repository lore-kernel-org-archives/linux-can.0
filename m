From: Alexander Gerasiov <a@gerasiov.net>
Subject: jcat binary name conflict
Date: Mon, 13 Apr 2020 12:53:04 +0300
Message-ID: <20200413125304.3a57fe8d@fran.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gans.gerasiov.net ([78.46.205.176]:53958 "EHLO
        mail.gerasiov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgDMKCc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Apr 2020 06:02:32 -0400
Received: from fran.gerasiov.net (unknown [178.154.217.48])
        by mail.gerasiov.net (Postfix) with ESMTPSA id D3799FC5EE
        for <linux-can@vger.kernel.org>; Mon, 13 Apr 2020 12:53:07 +0300 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello, there.

I just found conflict in binary name jcat with one from sleuthkit
package: https://bugs.debian.org/956530

I'm going to rename the binary to j1939cat in debian package.
May be you should do the same with it (or even with other j.* tools) in
upstream sources.

-- 
Best regards,
 Alexander Gerasiov

 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
