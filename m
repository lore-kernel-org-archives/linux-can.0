Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232163;
	b=1eyZmrgH+XWfGgl5UqaBs4QXP187UcB042eL9vbbpOavhTXXzzrYWE/z0aoTScN1VoVp
	 tEIfu0KYZbmJc8OnqIio8lzVgYox9Qx6dNXggYowRvW/DdTF8XtsDRQYWRdQFuzwr1VdG
	 qM2YiWFXiAnlbMR0zR0KPgmL0Y+RgehRZAxPa4NmHA6SMakMlrxZjRTVd6ssmqlbNjtBU
	 tYjRovDPoiaYPaMnomhx8drlSwjMDyoK8I6QaZwzzLxjIVMAKC7plGz6O5lNVgbF2W9nQ
	 +LTbw6O2TIU+HPY98zi9COO+Nzfbsw4XF5sJyDkiMcfjz89sQyHX05OmIMo1BnQMb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232163;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=HUFMRdJh5L6LU4pmqmKEHxDfGt/Xqm9jj/GYmHv51FM=;
	b=xYuVeZKiVEXS+UreRhYVmPo8/mc+4OD76Bnf/L0rkBKa0tZZEhrEwcjHOjB4hhHQjgDH
	 Aowz+Eo1WVoweH/PxMFEV28jitKEYRxST/J7GMEZtqhmYIjfOz0Lo5LZeOLz5ceYICwyg
	 Qmsx11TSjVaxld2+teHttyzijZ1Lf+1mRh1l827EwEpsYEXFV7a/ZJ8B7zrGGSafd4iem
	 xEB6CNrv4SUA7hmEd1b9hzOeRzDtSLjW3OrJuk1gTLgHeQ12nIB0gYzftC2RQN0WP6AIG
	 vG1tJqGgq9fRnpxOuAtNd+fHyjcUijz1pkyPPpV714JRqQhBg18s5LgfJhw4EGTIZTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=tBk3IxFQ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54730606A336;
	Mon,  9 Nov 2026 13:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54730606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=tBk3IxFQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=HUFMRdJh5L6LU4pmqmKEHxDfGt/Xqm9jj/GYmHv51FM=; b=tBk3IxFQ+sYgPjTN/VI97jvmdm
	Rm7sc99QT9cq+Zb5SaKiZS9fZIFo1w+S/XtM+k0LTif3cVzwNDeesoh1IRIZf7F/5yOjPwjXB0mQz
	bVxlYMOedxJrw1spyMesFR0PL3sdIkI6dUugL2exx2Ns3FoFevVegURubQnuUI3qMYMXJXDxtwOjS
	zeJFI0RBpzA8QSpid1aG5ws8Uf/Mf+NAKU8JPjmVuURS/r2V4IhbK1OYwmX+wqStcHNTFykoKBopV
	3mZ0eE2Cm8Oa8GhZLvHAJ/1L6lEU1GOjQMhw+ymrpnF6s8mcTxpJZnA+pNqPeNCVE2vmwXH4d7/kk
	9014eR7A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQPkP-00BfMg-1l;
	Mon, 09 Nov 2026 13:49:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Nov 2026 05:46:27 -0800
Subject: [PATCH RESEND v2 1/2] can: j1939: convert to getsockopt_iter
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-getsock_two_can-v2-1-763f87fb49b2@debian.org>
References: <20261109-getsock_two_can-v2-0-763f87fb49b2@debian.org>
In-Reply-To: <20261109-getsock_two_can-v2-0-763f87fb49b2@debian.org>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713; i=leitao@debian.org;
 h=from:subject:message-id; bh=Mix/e/rZPt6C+M/+y1NvJNhAMpnntuJoe4+M+NANAuo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8c9ZJc+Ax/pJJxVeoPoYxtvgmpWDLUdlDhppN
 wQE87QWc8eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavHPWQAKCRA1o5Of/Hh3
 bUYvD/wIVGbYo4NPMN1gHBkdNy0wIKbhje/YwCIWn8BMCLy37KsKu4ACoQ0s0TM7cu2TMR8CEoL
 6I/XCMA7C7anePJ0zRN5uL5IUTCSGNq4/MsEg4FjMKPG72jAc78QHd1ktCKR5F2dQ4MrPZU4fpB
 SznwnotfrOWyJFbtNBXgZvPioPT7nIK1FhlkqotNrn3d6YjDyCbySUu+QBzWCFfnxS8tZuj/xO/
 fDnGBeivZqAxsGAAJZkwSIE0fdUzbs4Yx1dOwOoBpP8hTaQ1uR7or3Bb3z7Y0BXDG2xoD1j0kI5
 AClGN8ZTbPpHWDvv+wkjlTIqSZcVpXUi07IjrSH1gbNsUjTDTidhL+6UV86I4dhrCL/bvR50Psr
 M626DAFFnoCsXz9aWLK2W2SvxsJCso1USWNWm6eq/gwcSvEbiBPqXzCcGg1kx4D/suaw3wu4rX8
 t4jVYN9L+EJO6CrMAW6Lt2/6iXHZH8qbyUMB7gItlCndg+ZayPUH4DytlXc8qwE8HcKnQIbJP0a
 P5UfMpYuzOzD/AFfn8HfHIjkHTV+y5LbnpLtqeI8WSXRGWw/egRoXiCL9AvS8MOOfFFWSEFpRVi
 CEkA04JUuvNxAKPwoFui+su6LX94sPDvQkfHCMLRhHndNtme9iDvmZw7PuIJGFhT8XHfjndd5gx
 jAcbxl3ITWjM4IA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert CAN J1939 socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of copy_to_user()
- Restructure the chained if/else if (which depended on put_user() being
  an expression) into a nested if/else block now that opt->optlen = len
  is a statement
- Add linux/uio.h for copy_to_iter()

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/can/j1939/socket.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4a5..d0c6ce607b0dc9 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -17,6 +17,7 @@
 #include <linux/can/skb.h>
 #include <linux/errqueue.h>
 #include <linux/if_arp.h>
+#include <linux/uio.h>
 #include <net/can.h>
 
 #include "j1939-priv.h"
@@ -767,7 +768,7 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct j1939_sock *jsk = j1939_sk(sk);
@@ -779,8 +780,7 @@ static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
 
 	if (level != SOL_CAN_J1939)
 		return -EINVAL;
-	if (get_user(ulen, optlen))
-		return -EFAULT;
+	ulen = opt->optlen;
 	if (ulen < 0)
 		return -EINVAL;
 
@@ -804,11 +804,16 @@ static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
 	 * but most sockopt's are 'int' properties, and have 'len' & 'val'
 	 * left unchanged, but instead modified 'tmp'
 	 */
-	if (len > ulen)
-		ret = -EFAULT;
-	else if (put_user(len, optlen))
+	if (len > ulen) {
 		ret = -EFAULT;
-	else if (copy_to_user(optval, val, len))
+		goto no_copy;
+	}
+
+	opt->optlen = len;
+	/* Even if the copy below fails, we want to update optlen. This is
+	 * a bit confusing, but, it preserves the original behaviour
+	 */
+	if (copy_to_iter(val, len, &opt->iter_out) != len)
 		ret = -EFAULT;
 	else
 		ret = 0;
@@ -1385,7 +1390,7 @@ static const struct proto_ops j1939_ops = {
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
 	.setsockopt = j1939_sk_setsockopt,
-	.getsockopt = j1939_sk_getsockopt,
+	.getsockopt_iter = j1939_sk_getsockopt,
 	.sendmsg = j1939_sk_sendmsg,
 	.recvmsg = j1939_sk_recvmsg,
 	.mmap = sock_no_mmap,

-- 
2.53.0-Meta

