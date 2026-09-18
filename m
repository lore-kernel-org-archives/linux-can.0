Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAC4B7A53
	for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729291; cv=none; b=cXHmJlL6s8tcwCJmAhGMdrzkJ8Bbth8xihnepvEDwTEcQkboaCB+LCQpB+SHKcn3iHbc77EAzlNQDXizX8VlVlMwNp0KSgOLibTbu5gm3P+vFNUkfXX48bAxxKijvKq4oIfYIyDg0ABW1x+xtXroXw13k2hNGkn/iX+qHKqatTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729291; c=relaxed/simple;
	bh=pHbBz+S8xEejNMUWSAFZbzLNSweTHGPtXBRxivMnMf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNB3XSE7sa3IiLop5Ed8EtNE+lTol288RxoNYE389oyLWbxhW71jfArBtRN6EGuXFQw6Kg2zA9ncUwDfyBc3BB2lCrX0gbSICRM4ndJhaRe0lVabnPEnInXlG3synQ+O9XImh6YxBAxvg7i6v+8IP/LlvC5cKgY8rHF57BPPIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sbw5he4U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MsIIQq4n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sbw5he4U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MsIIQq4n"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9dYhf705507
	for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 11:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lWswSoekF7IT3Yxcc40Z7y8MoP4qOcIdr70
	QbS4iBZQ=; b=Sbw5he4UvXM3m6BznJWgw1QUL7ZOMlWCmO9ORrPOowV7n+hxyiO
	AkZLqUASsKF8oOAKXgTTle6uGX2xMJiesScLKzyuon3GBqsvq/66P5RZDzCZw+i4
	pNesVP9YvmtnpfPtUPrmYcLEcb9SglgWIaZ+swnW4UNkioKBBbvKNLfglZahS4bu
	TPBcrtYCHtLO/u+I4Cenn7za6PZTMR36KvZ6MsI8MITarrOogfqRRfLupPAaZVHp
	9nRY4z9ebwQTgWMosRyD+n48OGe0SyFFDRGidcUCvUi6Hjt0NuDEZnTl9ZA0ESn8
	R45UruT7LTsBrGUfRp4E7BHX0rNTDaTmN/g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grxp2sdr0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 11:01:29 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c8487ce333so148857e0c.1
        for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789729289; x=1790334089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWswSoekF7IT3Yxcc40Z7y8MoP4qOcIdr70QbS4iBZQ=;
        b=MsIIQq4nLLvBzgV3IUo/pHW9IW+1Q/wIYxxEdPabhx6EoyzRJGYdkHjVjSk1yae/7R
         nMohwQR+FIWOacParv6qHvJedjJuWR4qQVnjTbTYL0LPMgTwahJzWj1++oUdItdx/2+w
         XlhHBTuX+xYcxHbQunbFGagHMDfA4m15BpYTWYPRManQWBKEvmAANAJl3y6fnC6gQ6oc
         4rEf+JstemaMe3MVGhirJBvBDt3DDOuVeJA/T9+nBtlMqHxfVr29OcC/fGmYls/OSWYW
         p/FbLDcSFGUJq7WrObU1YtVeOuq/SqgnITH8/SCm9GHAAoYA/TfHQhKBu02hBtFIIlG6
         7hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789729289; x=1790334089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWswSoekF7IT3Yxcc40Z7y8MoP4qOcIdr70QbS4iBZQ=;
        b=llgLVvML5T8aHQJEjcF2bp+NEpqs64NAl3WOzU2CAz8dmzwJnzkpO+BLDG4popG/yb
         bWl7i/q+mWkqiNPyVPctlNGXBkzaBBqFzB9DdQ3zFd/Aycckx1bILgZylWdk6fGTxIzG
         ROozXhF9osDWSlpNT6yTHwLKXJUdDH2e/FUK6mBYslhYXe1ZS6zYD+EL+JbRDpY5Ve9e
         vRtCakR8T6VYAv6x2b6F+X3tpTKiv1tcTNMXyWsz6CgW6a4rpzt3+JqGPoUfLtieCyJS
         Wakzfp5uT+L7A28wWzXQKXMNLlw/jkk3X8AY/sZKN8TeBZhEl8eK5S72G7I9LAX/cyQe
         Gj5g==
X-Forwarded-Encrypted: i=1; AKwUvByOu2T7+X147Vc1Ze4TdTUdBFAxO5P7vk6DaEtDf+DuyRDaWPXL8PylvYexc/DegPdOCJ5A2CfTt2E=@vger.kernel.org
X-Gm-Message-State: AFuF++n3WccWr4SpVixjjJISrN6eDhzyGSE8Bmr3t/w92hmOIsmZnglf
	SZDsOJY49rn3ffGIr3dJIWm+yHcz56mPnsaTmE7KSJCmyBHGOWmNnbQ6WmeC/WvKswalKjTTRq8
	2oB9Uucykwb6tNoU1nOyk5xOhiScdSso9imhrp35nREuya0pIAq2aAIKYHFBLTd30C2IT4ZI=
X-Gm-Gg: AYBFou3CYBYxrWuydTSU+HH2Y9Vz4ZYlqn56IOre10V5HFpfzEPhz3NF64JZqHvNynv
	QynhB/ZggTZqwGba3bZnqAbOXK1Hs3Sc+XB4SCBmIlNHLl6DAhnjlFRO4ywdNJevodzYr8K7cYc
	YuPbm7A9wJlOxj71hfAfZQsV2Pv8DM0DZKuzIre7OT9OlwW8XmbVhhX+mKi6Sp5oKAUfU+LuaL0
	LBoYb1WmMUp8MIPcnRJp6fUznolgQsSDCXN6c80SvqzKOfVYIFEGcsnyCuF7hLt9PTlQtl0S+xT
	TziGGjJxk2JioBFxhDkLy0cUddPhX3dZs9bUmGK5KHa6SY1zDO9z8Gsy40huI4iJCBJMMZyzmiG
	zfoosL2D6qfJQ8O0=
X-Received: by 2002:a05:6102:41aa:b0:7a1:f951:f2fd with SMTP id ada2fe7eead31-7a55c8841d8mr694334137.16.1789729286879;
        Fri, 18 Sep 2026 04:01:26 -0700 (PDT)
X-Received: by 2002:a05:6102:41aa:b0:7a1:f951:f2fd with SMTP id ada2fe7eead31-7a55c8841d8mr694082137.16.1789729284751;
        Fri, 18 Sep 2026 04:01:24 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc56eff84sm41962245e9.1.2026.09.18.04.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:01:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: phy: ti,tcan104x-can: Fixup unapplied constraint to ti,tcan1042 family
Date: Fri, 18 Sep 2026 13:01:17 +0200
Message-ID: <20260918110116.94024-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=pHbBz+S8xEejNMUWSAFZbzLNSweTHGPtXBRxivMnMf8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqrRn9JeRDJ+Cu211xd7NxyDHXSpUbSvXvI6xDR
 z8uWbYaj7SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaq0Z/QAKCRDBN2bmhouD
 11vpD/9F4q+9DXtX1IBVN3COr3L72i22jCFz+K/j0McOx/eFWpncTlBQJWqmdFeUfcR1a+/B0ww
 eTpexVvJU0qKOFzn89HChWOcZdgzBV53hTGXo9ert9DTKQOSTuhoLn0rJdGKCLrf2ZRImYBxpjY
 YIIfgtQHUeaPX+zPdbPlaUP1oJI8PgVhQSBXlHQDru0t/4YE8NEn38vjsVXWRJ3SB6gV6XaenK1
 EiCVSDqB46QGt2CEwzIRDE41sR1/krWJMDVoc25b9gEplzxoJYnoMDRju8+kiLwWA1carL0qAaU
 Q6LtSvDWnQd94eIE1PBjVfx/+B8y5rNTg77CwkYVpjDgfYKgDysaSEQYp3jQa/fRhHbuWvS74sE
 qbSLt8WR8rjRG0wekHCVLa+swed9nnogq8+XDyjro5sXTymfXWk7jN355lcTmbQbw9JIFbV4oOX
 4KJSgPuSRcWBpwJSXBBt542PrZJNCD7egyS8smaKekVmEPExXew5teimguv1GKTXVz9NBfBPhzC
 pqMFEJLQd8oEPER/+82J3XbOFrg94LnL1fjH3xULv/HpvlBPUMHqaXRW0bmDopo/ujLXKKFjNPp
 AHEh2E+daWDu5e799/dqCNIj9fKA4xc7SZsK3Nx+eMk1tvzkoc2QD4stlQwQIM6eSSWp5F2ZIf0 /G1G6ZNrVpYEk/A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE1NCBTYWx0ZWRfX2s//UTxZGBQc
 Rep8PpTQ9/sPed2dT3HktGS+0enEHOCWFHoF6OMsIPF8sm0nwMOhXLgd6/nQqPfr806yngdYNjx
 LE8m4v+01Xp+H+VRsBj4cvplHzR5fNk=
X-Proofpoint-GUID: I3yNx6cfpLv317aj2SaKccC0btB8gqRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE1NCBTYWx0ZWRfX2w6KMYKA/eBJ
 vOK4U7lsoO7Tw7Kyf2QkYlP45o3X5QSYM26ZY7hnvoN6dMqZ4rbsZLZcJQ0genPhrujEzBCf+Lo
 YEru0k2zmg4pp5RXao4zIetdaX5p7Sk8gc2HfoJl7wRKaMLmN6mTIdB9PLjV/Ces2NVnpAN1RNI
 Gq7Ck9pt2B3CLxyBYq/6f60xJ6YI790QcKHnou6ubg6l4/h2zzQOV26a54nH3Pb3zVLpabjMa4c
 JGAMakbZ3s9kw6yhzcgO2WJp4IbPYejD/luJ+xIR3IR2znlHuZp/2k67102Dcz15bIz0wf15EVQ
 SHHvq2ZkuYh9fKsc3a1y83Hi/bj0W1BxzdzMTwa8THOfDbT7q3MMeh/NABZMiW5t19Hleg4Pj/m
 SK2/mM8a/CJj/fGHNNm8+KsAL4PzZDbJTPpbXLudPjsNvqbYaxlzZ+hbOPuEQezgl0sMtQiqN8v
 4nI5bZdHU+d9ojJaGuw==
X-Proofpoint-ORIG-GUID: I3yNx6cfpLv317aj2SaKccC0btB8gqRz
X-Authority-Analysis: v=2.4 cv=cNF1IVeN c=1 sm=1 tr=0 ts=6aad1a09 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=aAtEoCzvOngrQmLLZK8A:9 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180154

ti,tcan1042 is also used as fallback for a few devices, thus the check
in "if:" conditional should use "contains" to properly validate these
other devices.  The other compatibles used in the changed enum are used
alone, so it does not affect them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml         | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 9f5c37ca6496..0cf5fa21106b 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -71,10 +71,11 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - nxp,tjr1443
-            - ti,tcan1042
-            - ti,tcan1043
+          contains:
+            enum:
+              - nxp,tjr1443
+              - ti,tcan1042
+              - ti,tcan1043
     then:
       properties:
         '#phy-cells':
-- 
2.53.0

