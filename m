From: janusz.uzycki@elproma.com.pl
Subject: Re: [PATCH] slcanpty
Date: Mon, 10 Jun 2013 11:36:24 +0200
Message-ID: <f4dc05d8086417bb0b0b3613a0e93311@beep.pl>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
 <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
 <51B0D58F.2010401@hartkopp.net> <6f9fdd56db06e6029218834c526f7d15@beep.pl>
 <51B310DC.8040509@hartkopp.net> <5dedc0b6441b754aebf3b560756932b8@beep.pl>
 <2b96a7606efb82e512f328eb2260b4bd@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout15.mailmx.agnat.pl ([193.239.45.95]:37375 "EHLO
	mailmxout15.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753236Ab3FJJgl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 05:36:41 -0400
In-Reply-To: <2b96a7606efb82e512f328eb2260b4bd@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

My proposal of fix:

 From 8047986ae5ea63150cd7a70e14a3f5ed0adef617 Mon Sep 17 00:00:00 2001
 From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Date: Mon, 10 Jun 2013 11:31:04 +0200
Subject: slcanpty: pty terminal flags fixed (NL -> CR)


Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
  slcanpty.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slcanpty.c b/slcanpty.c
index 635d12a..1e98f8c 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -454,7 +454,9 @@ int main(int argc, char **argv)

         /* disable local echo which would cause double frames */
         topts.c_lflag &= ~(ICANON | ECHO | ECHOE | ECHOK |
-                          ECHONL | ECHOPRT | ECHOKE | ICRNL);
+                          ECHONL | ECHOPRT | ECHOKE);
+       topts.c_iflag &= ~(ICRNL);
+       topts.c_iflag |= INLCR;
         tcsetattr(p, TCSANOW, &topts);

         /* Support for the Unix 98 pseudo-terminal interface /dev/ptmx 
/dev/pts/N */
--
1.7.11.3

BR
Janusz

