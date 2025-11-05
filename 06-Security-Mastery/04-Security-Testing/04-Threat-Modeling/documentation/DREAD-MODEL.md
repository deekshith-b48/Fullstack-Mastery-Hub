# DREAD Threat Model

## 📚 Overview

DREAD is a risk assessment model for quantifying threats. It helps prioritize threats based on risk scores.

## 🎯 DREAD Components

### DREAD Factors

1. **Damage**: How bad is the damage?
2. **Reproducibility**: How easy to reproduce?
3. **Exploitability**: How easy to exploit?
4. **Affected Users**: How many users affected?
5. **Discoverability**: How easy to discover?

## 🔍 DREAD Scoring

### Score Threats

```javascript
// DREAD scoring
function scoreDREAD(threat) {
  const scores = {
    damage: scoreDamage(threat), // 0-10
    reproducibility: scoreReproducibility(threat), // 0-10
    exploitability: scoreExploitability(threat), // 0-10
    affectedUsers: scoreAffectedUsers(threat), // 0-10
    discoverability: scoreDiscoverability(threat) // 0-10
  };
  
  const totalScore = (
    scores.damage +
    scores.reproducibility +
    scores.exploitability +
    scores.affectedUsers +
    scores.discoverability
  ) / 5;
  
  return {
    ...scores,
    totalScore: totalScore,
    risk: getRiskLevel(totalScore)
  };
}

function getRiskLevel(score) {
  if (score >= 8) return 'critical';
  if (score >= 6) return 'high';
  if (score >= 4) return 'medium';
  return 'low';
}
```

## 🔍 DREAD Examples

### Example Scoring

```javascript
// SQL Injection DREAD score
const sqlInjectionDREAD = {
  damage: 10, // Complete database compromise
  reproducibility: 10, // Always works
  exploitability: 8, // Relatively easy
  affectedUsers: 10, // All users
  discoverability: 9, // Well-known vulnerability
  totalScore: 9.4,
  risk: 'critical'
};
```

## 🛡️ Best Practices

1. **Consistent**: Consistent scoring
2. **Objective**: Objective assessment
3. **Documentation**: Document scores
4. **Review**: Review scores
5. **Prioritization**: Use for prioritization
6. **Updates**: Update scores
7. **Context**: Consider context

---

**Next**: Learn about [Attack Trees](./ATTACK-TREES.md)

