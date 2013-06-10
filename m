From: janusz.uzycki@elproma.com.pl
Subject: [PATCH 1/2] slcanpty: "slcanpty < /dev/null" issue fix
Date: Mon, 10 Jun 2013 11:42:35 +0200
Message-ID: <a6a53837d3a628d0a188d974acfd2597@beep.pl>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
 <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
 <51B0D58F.2010401@hartkopp.net> <6f9fdd56db06e6029218834c526f7d15@beep.pl>
 <51B310DC.8040509@hartkopp.net> <5dedc0b6441b754aebf3b560756932b8@beep.pl>
 <2b96a7606efb82e512f328eb2260b4bd@beep.pl>
 <f4dc05d8086417bb0b0b3613a0e93311@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout15.mailmx.agnat.pl ([193.239.45.95]:38804 "EHLO
	mailmxout15.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752919Ab3FJJml (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 05:42:41 -0400
In-Reply-To: <f4dc05d8086417bb0b0b3613a0e93311@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

Other proposal:

 From 65c62e93ddabceacc9ef6059776a640967206bc1 Mon Sep 17 00:00:00 2001
 From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Date: Fri, 7 Jun 2013 18:15:33 +0200
Subject: [PATCH 1/2] slcanpty: "slcanpty < /dev/null" issue fix

/dev/null returns EOF therefore select() finishes immediately. Now EOF
is probed on start.

Other /dev/null as stdin workarounds:
- lscanpty ... < /dev/ptmx (dirty but works)
- cat </dev/null | slcanpty ... (doesn't work for me and even the patch
   is "disabled" then)

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
  slcanpty.c | 22 +++++++++++++++++++++-
  1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/slcanpty.c b/slcanpty.c
index 061c1ab..f312362 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -363,6 +363,23 @@ int can2pty(int pty, int socket, int *tstamp)
         return 0;
  }

+int check_select_stdin(void)
+{
+       fd_set rdfs;
+       struct timeval timeout;
+       int ret;
+
+       FD_ZERO(&rdfs);
+       FD_SET(0, &rdfs);
+       timeout.tv_sec = 0;
+       timeout.tv_usec = 0;
+       ret = select(1, &rdfs, NULL, NULL, &timeout);
+       if (ret < 0) return 0; /* not selectable */
+       if (ret > 0)
+               if (getchar() == EOF) return 0; /* EOF, eg. /dev/null 
*/
+       return 1;
+}
+

  int main(int argc, char **argv)
  {
@@ -372,6 +389,7 @@ int main(int argc, char **argv)
         struct sockaddr_can addr;
         struct termios topts;
         struct ifreq ifr;
+       int select_stdin = 0;
         int running = 1;
         int tstamp = 0;
         int is_open = 0;
@@ -393,6 +411,8 @@ int main(int argc, char **argv)
                 return 1;
         }

+       select_stdin = check_select_stdin();
+
         /* open pty */
         p = open(argv[1], O_RDWR);
         if (p < 0) {
@@ -464,7 +484,7 @@ int main(int argc, char **argv)
         while (running) {

                 FD_ZERO(&rdfs);
-               FD_SET(0, &rdfs);
+               if (select_stdin) FD_SET(0, &rdfs);
                 FD_SET(p, &rdfs);
                 FD_SET(s, &rdfs);

--
1.7.11.3


